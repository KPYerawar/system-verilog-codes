`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2026 08:10:23 AM
// Design Name: 
// Module Name: CODE_25_smrt_dma
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


module CODE_25_smrt_dma(
input  enable ,
output logic [7:0] data_out,
input [1:0] opcode ,
input [7:0] address ,
input [7:0] data_in 
    );
    
    always @(*) begin 
    if (enable == 0 ) 
    data_out = 0 ;
    else begin 
    case (opcode ) 
       2'b00: data_out = address + 5 ;
       2'b01 : data_out = data_in ;
       2'b10 : data_out = data_in * 2 ;
       2'b11 : data_out = 255 ;
       default : data_out = data_in ;
       endcase 
       end 
       end
       
        
    
endmodule
