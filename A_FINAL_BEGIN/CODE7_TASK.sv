`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 01:48:54 PM
// Design Name: 
// Module Name: CODE7_TASK
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
class demo;
task delay_print ();
$display ("this is demo of task time = %t ", $time );
#20;
$display ("delay was given here 0f 20 ns time = %t" , $time );
endtask 
endclass

module CODE7_TASK;
demo d1 ;
initial begin 
d1 = new();
d1.delay_print();
end 
endmodule
