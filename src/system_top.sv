`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 12:15:59 AM
// Design Name: 
// Module Name: system_top
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


// Define the top-level module for the KR260 system
module kr260_top(
   // Declare the output pin for the LED
    output logic walk_left,
    output  logic walk_right,
    output logic aah,
    output logic digging,
    output logic jumping
   );
 logic clk;
   logic areset;
   logic bump_left;
   logic small_bump_left;
   logic bump_right;
   logic small_bump_right;
   logic ground;
   logic dig;
  
 // Declare system clock signal
 // Declare active-low reset signal
 // Declare input signal a
 // Declare input signal b
 // Declare input signal c

 // Instantiate the system module
 // Connect system clock to the system module
 // Connect reset signal to the system module
 // Connect input a to the system module
 // Connect input b to the system module
 // Connect input c to the system module
    system dut2 (
    .clk(clk),
    .areset(areset),
    .bump_left(bump_left),
    .bump_right(bump_right),
    .small_bump_right(small_bump_right),
    .small_bump_left(small_bump_left),
    .ground(ground),
    .dig(dig)
    );
 // Instantiate the triple voter module
 // Connect system clock to the voter module
 // Connect reset signal to the voter module
 // Connect input a to the voter module
 // Connect input b to the voter module
 // Connect input c to the voter module
 // Connect the output of the voter to the LED
 top dut1 (
    .clk(clk),
    .areset(areset),
    .bump_left(bump_left),
    .bump_right(bump_right),
    .small_bump_right(small_bump_right),
    .small_bump_left(small_bump_left),
    .ground(ground),
    .dig(dig),  
    .walk_left(walk_left),
    .walk_right(walk_right),
     .aah (aah),      
    .digging(digging),
    .jumping(jumping)
    );
endmodule

