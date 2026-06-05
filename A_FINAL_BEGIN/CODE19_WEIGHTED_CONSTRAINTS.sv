`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2026 01:29:46 PM
// Design Name: 
// Module Name: CODE19_WEIGHTED_CONSTRAINTS
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
// here we can handle the possibility pf occurance of constraints 
//insted of inside we use dist 
class weightgen;
rand bit [1:0] packet;
// 0 control 
//1 data 
//error 
constraint cons1 {
packet dist {
0 := 20,
1 := 75,
2 := 5
};
}  
endclass 

module CODE19_WEIGHTED_CONSTRAINTS;
weightgen w1 ;
initial begin 
repeat (20) begin 
w1 = new();
w1.randomize();
$display (" current packet = %d " , w1.packet);
#5;
end 
end
endmodule
