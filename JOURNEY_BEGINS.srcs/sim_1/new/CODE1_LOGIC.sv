`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 09:25:53 AM
// Design Name: 
// Module Name: CODE1_LOGIC
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


module CODE1_LOGIC;
logic [3:0] a ;
logic [3:0] b ;
logic [4:0] sum ;
initial begin 
$monitor ("a = %b , b = %b , sum = %d ", a , b, sum );
end 
initial begin 
a = 4'd10;
b = 4'd10;
#20 ;
sum = a + b ;
end 
endmodule
