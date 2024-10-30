`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2024 12:22:42 PM
// Design Name: 
// Module Name: counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter_tb( );
 logic clk;
  logic reset;
  logic areset;
  logic signal;
  
  initial begin
  clk = 0;
  reset = 0;
  areset= 0;
  end
  //----------------clock 1mHZ May be!!------------------
  always #5 clk = ~clk;
  /////---------------------design instantiation-------------------
  counter dut (
      .clk(clk),
      .reset(reset),
      .areset(areset),
      .signal(signal)
  );
  initial begin 
  $monitor("time : %0t, areset : %0d ,reset : %0d , signal : %0d , count :%0d", $time,areset,reset,signal,dut.count);
  //---------RESEt and set---------------
 #10;
  areset = 1;
  reset =1;
  assert(signal ==0 && dut.count==0) else $error("Not reset Properly");
   #10;
 areset = 0;
  reset =0;
  end
endmodule
