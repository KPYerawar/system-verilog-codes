`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2026 03:18:27 PM
// Design Name: 
// Module Name: CODE18_CONDITIONAL_CONSTRAINTS
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
class automation ;
 rand bit switch ;
 rand bit [7:0] packets ;
 
 constraint cond_cons {
    if (switch == 1 ){
      packets inside {[100 : 200]};
      }
    else {
      packets inside {[0:99]};
      } 
      }
endclass 
      

module CODE18_CONDITIONAL_CONSTRAINTS;
automation a1 ;
initial begin 
repeat (10) begin  
a1 = new ();
a1.randomize();
$display (" mode = %d , packets = %d " , a1.switch , a1.packets);
#5;
end 
end

endmodule
