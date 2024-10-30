class transaction;
    logic areset;
    logic bump_left;
    logic bump_right;
    logic ground;
    logic dig;
    
    function void randomize1();
        this.bump_left = $urandom_range(0, 1);
        this.bump_right = $urandom_range(0, 1);
        this.ground = $urandom_range(0, 1);
        this.dig = $urandom_range(0, 1);
    endfunction
endclass

class driver;
    virtual top_if vif;
    mailbox transaction_mb;
    
    function new(virtual top_if vif,mailbox transaction_mb);
        
        this.vif = vif;
        this.transaction_mb = transaction_mb;
        
     endfunction
     
     task run();
      transaction tr;
      forever begin
        transaction_mb.get(tr);
            vif.bump_left <= tr.bump_left;
            vif.areset <= tr.areset;
            vif.bump_left <= tr.bump_left;
            vif.bump_right <= tr.bump_right;
            vif.ground <= tr.ground;
            vif.dig <= tr.dig;
            $display("[DRV]:DONE GETTING I/P VALUES FROM TRANSACTION CLASS");
            @(posedge vif.clk);
            
        end
    endtask
endclass

class monitor;
virtual top_if vif;
mailbox monitor_mb;
function new(virtual top_if vif,mailbox monitor_mb);
        this.vif = vif;
        this.monitor_mb = monitor_mb;
     endfunction

task run();
    transaction tr;
    forever begin
     @(posedge vif.clk);
            monitor_mb.put({vif.walk_left, vif.walk_right, vif.aaah, vif.digging});
            $display("[MON]:DONE PUTTING O/P VALUES FROM TRANSACTION CLASS");

        end
    endtask
    
endclass


class env;
    driver drv;
    monitor mon;
    scoreboard sb;
    mailbox transaction_mb;
    mailbox monitor_mb;
    mailbox expected_mb;

    // Constructor to initialize the mailboxes, driver, monitor, and scoreboard
    function new(virtual top_module_if vif);
        transaction_mb = new();
        monitor_mb = new();
        expected_mb = new();
        drv = new(vif, transaction_mb);
        mon = new(vif, monitor_mb);
        sb = new(monitor_mb, expected_mb);  // Initialize the scoreboard
    endfunction

    // Run task to execute all components
    task run();
        fork
            drv.run();   // Driver sends transactions to DUT
            mon.run();   // Monitor collects the DUT's outputs
            sb.run();    // Scoreboard compares observed and expected values
        join_none
    endtask
endclass

class scoreboard;
    mailbox monitor_mb;      // Receives data from the monitor
    mailbox expected_mb;     // Receives expected data (from reference model or test case)

    // Constructor to initialize mailboxes
    function new(mailbox monitor_mb, mailbox expected_mb);
        this.monitor_mb = monitor_mb;
        this.expected_mb = expected_mb;
    endfunction

    // Main task to compare actual and expected outputs
    task run();
        logic [3:0] observed;  // 4-bit wide because of multiple outputs (walk_left, walk_right, aaah, digging)
        logic [3:0] expected;
        forever begin
            monitor_mb.get(observed); // Get the observed output from the monitor
            expected_mb.get(expected); // Get the expected output

            // Compare observed and expected
            if (observed !== expected) begin
                $display("ERROR: Mismatch detected at time %0t", $time);
                $display("Observed: %b, Expected: %b", observed, expected);
            end else begin
                $display("PASS: Match at time %0t", $time);
            end
        end
    endtask
endclass

//////////////////----------------------------------------------------------------------------------------------------------



module tb_top_module;
    logic clk;
    logic areset;

    // Declare the states
       parameter LEFT=0,RIGHT=1,FALLING_LEFT=2,FALLING_RIGHT=3,DIGGING_LEFT=4,DIGGING_RIGHT=5,SPLAT=6;

    top_if top_i(clk, areset);
    env env_i;
    top dut (
        .clk(top_i.clk),              // Connect clock
        .areset(top_i.areset),        // Connect asynchronous reset
        .bump_left(top_i.bump_left),  // Connect bump_left signal
        .bump_right(top_i.bump_right),// Connect bump_right signal
        .ground(top_i.ground),        // Connect ground signal
        .dig(top_i.dig),              // Connect dig signal
        .walk_left(top_i.walk_left),  // Connect walk_left output
        .walk_right(top_i.walk_right),// Connect walk_right output
        .aaah(top_i.aah),            // Connect aaah output
        .digging(top_i.digging)       // Connect digging output
    );


    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Reset logic
    initial begin
        clk = 0;
        areset = 1;
        #10 areset = 0;
    end

    // Test stimulus generation and expected value calculation
    initial begin
        transaction tr;
        logic [2:0] current_state = LEFT;  // Start in the LEFT state
        logic [3:0] expected_output;

        env_i = new(top_i);  // Instantiate the environment
        env_i.run();          // Run the environment (driver, monitor, scoreboard)

        for (int i = 0; i < 10; i++) begin
            tr = new();
            tr.randomize();    // Randomize inputs
            env_i.transaction_mb.put(tr);  // Send transaction to driver

            // Generate expected values based on the transaction and current state
            expected_output = generate_expected_output(tr, current_state);
            env_i.expected_mb.put(expected_output);  // Send expected values to scoreboard

            #10;
        end
        #100 $finish;  // End simulation after 100 time units
    end

    // Function to generate expected output based on transaction and current state
    function logic [3:0] generate_expected_output(transaction tr,  reg [2:0] state);
        logic [3:0] expected_output;
        logic walk_left, walk_right, aaah, digging;

        // Default output values
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        // State machine logic to determine expected outputs and transitions
        case (state)
            LEFT: begin
                if (!tr.ground) begin
                    state = FALLING_LEFT;
                    aaah = 1;
                end else if (tr.dig) begin
                    state = DIGGING_LEFT;
                    digging = 1;
                end else if (tr.bump_left) begin
                    state = RIGHT;
                    walk_right = 1;
                end else begin
                    walk_left = 1;
                end
            end
            
            RIGHT: begin
                if (!tr.ground) begin
                    state = FALLING_RIGHT;
                    aaah = 1;
                end else if (tr.dig) begin
                    state = DIGGING_RIGHT;
                    digging = 1;
                end else if (tr.bump_right) begin
                    state = LEFT;
                    walk_left = 1;
                end else begin
                    walk_right = 1;
                end
            end

            FALLING_LEFT: begin
                if (tr.ground) begin
                    state = LEFT;
                    walk_left = 1;
                end else begin
                    aaah = 1;  // Still falling
                end
            end

            FALLING_RIGHT: begin
                if (tr.ground) begin
                    state = RIGHT;
                    walk_right = 1;
                end else begin
                    aaah = 1;  // Still falling
                end
            end

            DIGGING_LEFT: begin
                if (!tr.ground) begin
                    state = FALLING_LEFT;
                    aaah = 1;
                end else begin
                    digging = 1;  // Continue digging
                end
            end

            DIGGING_RIGHT: begin
                if (!tr.ground) begin
                    state = FALLING_RIGHT;
                    aaah = 1;
                end else begin
                    digging = 1;  // Continue digging
                end
            end

            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end

            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase

        // Pack the outputs into a 4-bit vector
        expected_output = {walk_left, walk_right, aaah, digging};
        
        return expected_output;
    endfunction
endmodule

