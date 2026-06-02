`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 02:16:11 PM
// Design Name: 
// Module Name: CODE10_RACECAR
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


module CODE10_RACECAR;
initial begin 
$display ("race is staring %t",$time);
fork 
#30;
$display ("Car A crossed the finish line! %t", $time);
#15;
$display ("Car B crossed the finish line! %t",$time);
join 
end 


endmodule
