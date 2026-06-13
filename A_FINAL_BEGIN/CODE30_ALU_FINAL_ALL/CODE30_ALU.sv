`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2026 08:25:22 AM
// Design Name: 
// Module Name: CODE30_ALU
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


module CODE30_ALU(
input enable ,
input [1:0] opcode ,
input [7:0] a , 
input [7:0] b ,
output logic [7:0] result 
    );
    
 always @(*) begin 
 if (enable == 0 ) 
 result = 0 ;
 else begin 
 case (opcode )
    2'b00 : result = a + b ;
    2'b01 : result = a - b ;
    2'b10 : result = a & b ;
    2'b11 : result = a | b ;
    endcase 
  end 
  end 
    
endmodule
