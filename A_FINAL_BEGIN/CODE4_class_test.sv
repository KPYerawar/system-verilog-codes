`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:23:14 AM
// Design Name: 
// Module Name: CODE4_class_test
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

class claculator    ;
 function int multiply (int a , int b );
    int ans ;
    ans = a * b ;
    return ans;
    endfunction 
endclass

module CODE4_class_test;
initial begin 
 claculator calc ;
 int result ;
 calc = new();
 result = calc.multiply (10 , 30 );
 #20 ;
 $display (" result  = %d " , result );
 
end 
endmodule
