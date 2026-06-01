`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:31:35 AM
// Design Name: 
// Module Name: CODE5_tb_score
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
class scoreboard;
int matches1 ;
int mismatches ;
function void check_result (int expected , int actual );
if ( expected == actual )
$display (" yes matches ");
else 
$display (" not matches ");
endfunction endclass 




module CODE5_tb_score;
scoreboard s1;

initial begin 
s1 = new();
s1.check_result (10 , 10 );
#20 ;
s1.check_result (11 , 10 );
#20 ;
s1.check_result (12 , 10 );
#20 ;
end 
endmodule
