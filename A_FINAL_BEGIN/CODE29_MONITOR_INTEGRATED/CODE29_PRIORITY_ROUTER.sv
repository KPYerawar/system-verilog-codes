`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2026 07:51:35 AM
// Design Name: 
// Module Name: CODE29_PRIORITY_ROUTER
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


module CODE29_PRIORITY_ROUTER(
input  valid ,
input [1:0] priority_lvl,
input [7:0] data_in,
output logic [7:0] data_out ,
output logic error_flag
    );
    always @(*) begin 
    if ( valid == 0 ) begin 
    data_out = 0 ;
    error_flag = 0 ;
    end 
    
    else begin 
    
        case (priority_lvl) 
            2'b00 : begin 
                            data_out = (data_in / 2 );
                            error_flag = 0 ;
                    end 
             2'b01: begin 
                            data_out = data_in ;
                            error_flag = 0 ;
                    end 
            2'b10: begin 
                            data_out = data_in * 2 ;
                            error_flag = 0 ;
                   end 
            2'b11:  
                     if ( data_in > 100 ) begin 
                     data_out = data_in ;
                     error_flag = 0 ;
                     end 
                    else begin 
                       data_out = 0 ;
                     error_flag = 1 ;
                     end 
         endcase 
         end 
         end 
                        
endmodule
