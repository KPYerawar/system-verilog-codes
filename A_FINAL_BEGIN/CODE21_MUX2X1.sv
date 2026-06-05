`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2026 01:53:34 PM
// Design Name: 
// Module Name: CODE21_MUX2X1
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
module CODE21_MUX2X1(
  input in0 , in1 ,
  output y ,
  input sel
);
  assign y = sel ? in1 : in0 ;
endmodule
