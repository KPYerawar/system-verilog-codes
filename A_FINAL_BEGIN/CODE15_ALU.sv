`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2026 09:21:37 AM
// Design Name: 
// Module Name: CODE15_ALU
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
class instructions ;
rand bit [2:0] opcode ;
rand bit [7:0] vala;
rand bit [7:0] valb ;
endclass

class generator ;
mailbox mb ;
function new(mailbox m );
mb = m ;
endfunction 

task run();
instructions i1 ;
repeat (10) begin 
i1 = new();
i1.randomize();
mb.put(i1);
$display (" opcode = %d vala = %d valb = %d ",i1.opcode ,i1.vala ,i1.valb);
end
endtask 
endclass 




module CODE15_ALU;
generator gen ;

mailbox mbx ;
initial begin 
mbx = new ();
gen = new(mbx);
gen.run();
$display (" total velues changes in mailbox - %d ", mbx.num());
end 
endmodule
