`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 10:03:24 AM
// Design Name: 
// Module Name: CODE26_DRIVER_GEN
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

class packet26;
rand bit  enable ;
rand bit [1:0] port_sel;
rand bit  [7:0] payload ;

constraint cons1{
enable dist {
0 := 15 ,
1 := 85 }; }

constraint cons2 {
if (port_sel == 3 ) {
payload inside {[255:255]} ; }
else {
payload inside {[10:99]}; } 
} 
endclass 


class generator26 ;
mailbox mbx ;
packet26 p1 ;

function new(mailbox m );
mbx = m ;
endfunction 

task run();
repeat (15) begin 
p1 = new();
p1.randomize();
mbx.put(p1);
$display (" vaue randmized and put in mailbox ");
#10;
end
endtask 
endclass 

class driver26 ;
mailbox mbx ;
packet26 p1 ;
virtual CODE26_INTERFACES vif;

function new(virtual CODE26_INTERFACES v , mailbox m );
vif = v ;
mbx = m ;
endfunction 

task run();
repeat (15) begin 
p1 = new();
mbx.get(p1);
vif.enable = p1.enable ;
vif.port_sel = p1.port_sel;
vif.payload = p1.payload ;
#10;
$display (" enabe = %d ,port_sel = %d , payload = %d , porta_out =%d , portb_out = %d , portc_out = %d",p1.enable ,
p1.port_sel , p1.payload , vif.porta_out , vif.portb_out , vif.portc_out );
end 
endtask endclass 



 
module CODE26_DRIVER_GEN;
CODE26_INTERFACES intf();
CODE26_FINAL_PRAC PR1(
.enable (intf.enable ),.port_sel(intf.port_sel),.payload(intf.payload),.porta_out(intf.porta_out),
.portb_out(intf.portb_out),.portc_out(intf.portc_out));


generator26 gen1 ;
driver26 drv1;
mailbox mbx ;
initial begin
mbx = new();
gen1 = new(mbx);
drv1 = new(intf , mbx );

fork 
    gen1.run();
    drv1.run();
    join 
    $display ("ROUTER VERIFICATION COMPLETE");
     
end 
endmodule
