`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2024 02:28:43 PM
// Design Name: 
// Module Name: tb2
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


module tb2( );
logic clk;       
logic areset;     
logic bump_left;  
logic bump_right; 
logic ground; 
logic dig;    //---end of i/p 
 logic walk_left; 
 logic walk_right;
 logic aah;      
 logic digging;
 logic jumping; 
 logic small_bump_right;
 logic small_bump_left;
 
 
 
 initial begin
        clk = 1 ;      
        areset = 0;    
        bump_left = 0;  
        bump_right = 0 ; 
        ground = 0;     
        dig = 0; 
        small_bump_right=0;   
        small_bump_left=0; 
 end
 
 
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
    
    always #5 clk = ~clk;
    
    initial begin
    #10;
    areset  = 1;
    #10 ;
    areset = 0;
    ground = 1;
    #40;
    bump_left = 1;
    #40;
    bump_left = 0;
    #40;
    small_bump_right = 1;
    #40;
    small_bump_right = 0;
        #40;
    bump_right = 1;
    #40;
    bump_right = 0;
    #40
    small_bump_left = 1;
    #40;
    small_bump_left = 0;
    #40;
     bump_left = 1;
    #40;
    bump_left = 0;
    #40;
    small_bump_right = 1;
    #40;
    small_bump_right = 0;
        #40;
    ground =  0;
    #50;
    ground = 1;
    dig = 1;
    #50 
    ground = 0;
    #250;
    $finish;
    end
    endmodule