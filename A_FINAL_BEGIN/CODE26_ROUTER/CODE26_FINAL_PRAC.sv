`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 09:49:16 AM
// Design Name: 
// Module Name: CODE26_FINAL_PRAC
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


module CODE26_FINAL_PRAC(
input enable ,
input [1:0] port_sel,
input [7:0] payload ,
output logic [7:0] porta_out,portb_out , portc_out

    );
    
    always @(*) begin 
    if ( enable == 0 ) begin 
      porta_out = 0 ;
      portb_out = 0 ;
      portc_out = 0 ;   end 
      
      else begin 
      case (port_sel) 
 2'b0: porta_out = payload;
 2'b01: portb_out = payload ;
 2'b10: portc_out = payload ;
 2'b11 : begin 
    porta_out = 0 ;
      portb_out = 0 ;
      portc_out = 0 ;
      end 
      endcase end
      end
      
endmodule
