`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:14:14 AM
// Design Name: 
// Module Name: CODE3_MULTIPLY
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




module CODE3_MULTIPLY;
function int multiply (int a , int b );
int ans ;
ans = a * b ;
$display ("sum is = %d " , ans  );
return ans ;
endfunction

initial begin 
int a = 10;
int b = 20 ;
int sumis ;
sumis = multiply (a , b);
#20;
$display ("sumis = %d " , sumis );
end 
endmodule
