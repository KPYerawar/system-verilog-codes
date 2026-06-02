`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 01:53:13 PM
// Design Name: 
// Module Name: CODE8_TASK_TRAFFIC_LIGHT
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

class trafficlight;
task cycle ();
$display ("red at time = %t",$time );

$display ("green at time = %t",$time );

$display ("yellow  at time = %t",$time );

endtask 
endclass

module CODE8_TASK_TRAFFIC_LIGHT;
trafficlight t1 ;
initial begin 
t1 = new();
t1.cycle();
end 
endmodule
