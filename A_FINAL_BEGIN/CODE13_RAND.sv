`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2026 08:28:40 AM
// Design Name: 
// Module Name: CODE13_RAND
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

class packet ;
rand bit [7:0] data ; // it tells code that this verible is ready to take any randm number  
endclass
module CODE13_RAND;
packet pkt ;
initial begin 
pkt = new();
repeat (20) begin 
pkt.randomize(); // it searches the rand veribl n class to give him value all rand veribles 
$display (" data is = %d , " , pkt.data);
#20;
end 
end 
endmodule
