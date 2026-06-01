`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 09:40:20 AM
// Design Name: 
// Module Name: CODE2_DATATYPE
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
module CODE2_DATATYPE;
  bit bitdata;
  bit [7:0] bitbyte;
  byte bytedata ;
  int intdata ;
  longint longintdata ;
  shortint shortintdata;

  initial begin 
    // Changed $d to %d for shortintdata
    $display ("bitdata = %d ,bitbyte=%d , bytedata = %d, intdata = %d , longintdata = %d , shortintdata = %d ", 
      $size(bitdata), $size(bitbyte), $size(bytedata), $size(intdata), $size(longintdata), $size(shortintdata));
  end
endmodule