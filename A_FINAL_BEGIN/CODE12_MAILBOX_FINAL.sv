`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 02:51:02 PM
// Design Name: 
// Module Name: CODE12_MAILBOX_FINAL
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

class transaction;
rand bit [7:0]  data ;
endclass

class generator ;
mailbox mbx;
function new (mailbox m );
mbx = m ;
endfunction 

task run ();
repeat (2) begin 
get ();
#5;
$display ("data received %b " , data );
endtask 
endclass 


class drive ;
mailbox mbx;
function new(mailbox m );


module CODE12_MAILBOX_FINAL;
endmodule
