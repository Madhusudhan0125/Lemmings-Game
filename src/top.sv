`timescale 1ns / 1ps

module top(
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic small_bump_left,
    input logic bump_right,
    input logic small_bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aah,
    output logic digging,
    output logic jumping
);
    parameter LEFT=0, RIGHT=1, FALLING_LEFT=2, FALLING_RIGHT=3, DIGGING_LEFT=4, DIGGING_RIGHT=5, SPLAT=6, JUMP_LEFT=7, JUMP_RIGHT=8;
    
    logic [3:0] state, next_state;
    logic splat_left, splat_right;
    
    counter count_left (
        .clk(clk),
        .reset(~(state == FALLING_LEFT)),
        .areset(areset),
        .signal(splat_left)
    );
    
    counter count_right (
        .clk(clk),
        .reset(~(state == FALLING_RIGHT)),
        .areset(areset),
        .signal(splat_right)
    );

    // State transition logic
    always_comb begin
        next_state = state; // Default to current state
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else if (small_bump_left)
                    next_state = JUMP_LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else if (small_bump_right)
                    next_state = JUMP_RIGHT;
            end
            FALLING_LEFT: begin
                if (ground) begin
                    if (splat_left)
                        next_state = SPLAT;
                    else
                        next_state = LEFT;
                end
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    if (splat_right)
                        next_state = SPLAT;
                    else
                        next_state = RIGHT;
                end
            end
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
            end
            JUMP_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (!small_bump_left)
                    next_state = LEFT;
            end
            JUMP_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (!small_bump_right)
                    next_state = RIGHT;
            end
            SPLAT: next_state = SPLAT;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output assignments
    assign walk_left = (state == LEFT) && ~(state == SPLAT);
    assign walk_right = (state == RIGHT) && ~(state == SPLAT);
    assign aah = (state == FALLING_LEFT || state == FALLING_RIGHT) && ~(state == SPLAT);
    assign digging = (state == DIGGING_LEFT || state == DIGGING_RIGHT) && ~(state == SPLAT); 
    assign jumping = (state == JUMP_LEFT || state == JUMP_RIGHT) && ~(state == SPLAT);
  
endmodule