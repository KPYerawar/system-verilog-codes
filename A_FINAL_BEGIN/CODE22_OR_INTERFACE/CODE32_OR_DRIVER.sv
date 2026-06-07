`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2026 08:33:00 AM
// Design Name: 
// Module Name: CODE32_OR_DRIVER
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

class ordriver1 ;
virtual CODE32_INTERFACE vif ;
function new(virtual CODE32_INTERFACE v );
vif = v ;
endfunction 

task run ();
vif.a = 0;
vif.b = 1 ;
#5;
$display (" our exp = 1 , actual = %d",vif.out );
endtask 
endclass 


module CODE32_OR_DRIVER;
CODE32_INTERFACE intf();
ordriver1 o1 ;

CODE32_ORGATE dut (.a(intf.a),.b(intf.b),.out(intf.out));

initial begin 
o1 = new(intf);
o1.run();
end
endmodule
