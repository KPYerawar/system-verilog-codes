`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:02:19 AM
// Design Name: 
// Module Name: CODE1_FUNCTION
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


module CODE1_FUNCTION;
function int sum_function(int a , int b );
  int result;
  result = a + b ;
  return result ;
endfunction 

initial begin 
int sum ;
sum = sum_function (10 , 20 );
#20;
$display ("sum = %d " , sum );
end 
endmodule
