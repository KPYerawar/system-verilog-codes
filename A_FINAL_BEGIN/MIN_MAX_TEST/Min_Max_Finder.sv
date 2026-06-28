`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2026 02:19:53 PM
// Design Name: 
// Module Name: Min_Max_Finder
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

/*
WARMUP CHALLENGE: The Min/Max Finder (CODE31)

We are going to build a completely fresh, simple SystemVerilog environment.

The Hardware (DUT & Interface)

    Interface (CODE31_INTERFACE):

        a (8-bit logic)

        b (8-bit logic)

        max_val (8-bit logic)

        min_val (8-bit logic)

    DUT Logic: It is a simple combinational comparator.

        max_val gets the higher number between a and b.

        min_val gets the lower number between a and b.

        (If they are equal, both just get the value of a).

The Software Pipeline Requirements

    Packet (packet31): Randomize inputs a and b. Do not randomize outputs. Add a constraint so a and b are always inside the range of 10 to 50.

    Generator & Driver: Loop 15 times. Use a #10 delay.

    Monitor: Loop 15 times. Use your #9 and #1 trick to capture the inputs and outputs perfectly.

    Scoreboard: Loop 15 times. Predict what max_val and min_val should be using standard if/else logic, compare them to the physical results, and print [PASS] or [FAIL].

    Environment & Top: Wrap it all up cleanly just like you did in CODE30.

Take your time, map out the classes, and drop your full CODE31 code here when you are ready to see that wall of green [PASS] messages!
*/


module Min_Max_Finder(
input [7:0] a ,
input [7:0] b ,
output  logic  [7:0] max_val ,
output logic  [7:0] min_val 

    );
    
    always@(*) begin 
        if (a < b ) begin 
             max_val = b ;
             min_val = a ;
            end 
        else if ( a > b ) begin 
           max_val = a ;
           min_val = b ;
           end 
        else begin 
           max_val = a ;
           min_val = a ;
           end 
        end 
      
endmodule
