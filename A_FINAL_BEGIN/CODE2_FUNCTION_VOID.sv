`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:06:56 AM
// Design Name: 
// Module Name: CODE2_FUNCTION_VOID
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


module CODE2_FUNCTION_VOID;
function void voidtest (string name );
 $display("name is %s",name );
 endfunction 
 
 initial begin 
 voidtest("krushna");
 end 
endmodule
