`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2026 08:33:25 AM
// Design Name: 
// Module Name: CODE25_DRIVER_GENERATOR
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

class packet25 ;
 rand bit enable;
  rand bit [1:0]opcode;
  rand bit [7:0] address;
  rand bit [7:0] data_in;
  
  constraint cons1{
  enable dist   {
  0 := 10 ,
  1:= 90 }; }
  
  constraint cons2 {
  if (opcode == 0 ) {
  data_in inside {[0:0]}; }
  else {
   data_in inside {[100:150]}; }
   }
  
  endclass 
  
  class generator25 ;
  mailbox mbx ;
  packet25 p1 ;
  function new (mailbox m);
   mbx = m ;
   endfunction 
   
   task run();
   repeat(12) begin 
   p1 = new();
   p1.randomize();
   mbx.put(p1);
   $display (" packet created at instant = %t",$time );
   #5;
   end
   endtask 
   endclass
   
   class driver25 ;
   mailbox mbx ;
   packet25 p1 ;
   virtual CODE25_DMA_INTERFACE vif ;
   function new(virtual CODE25_DMA_INTERFACE v , mailbox m);
   vif = v ;
   mbx = m ;
   endfunction 
   
   task run ();
   repeat (12) begin 
   p1 = new();
   mbx.get(p1);
      vif.address = p1.address ;
   vif.data_in= p1.data_in  ;
   vif.enable  = p1.enable ;
   vif.opcode = p1.opcode;
   #10;
   $display (" ourput at data time = %t , data_in = %d , address = %d ,enable = %d , opcode = %d , data_out = %d " ,$time ,p1.data_in, p1.address , p1.enable ,p1.opcode , vif.data_out  );
   end 
   endtask 
   endclass 
   
   
   
module CODE25_DRIVER_GENERATOR;
CODE25_DMA_INTERFACE intf();

CODE_25_smrt_dma d1 (
.enable (intf.enable),.address(intf.address),.data_in(intf.data_in),.data_out(intf.data_out),.opcode(intf.opcode));

mailbox mbx ;
generator25 g1 ;
driver25 d2 ;

initial begin 
mbx = new ();
g1 = new(mbx);
d2 = new(intf , mbx);
fork 
g1.run();
d2.run();
join 
$display (" DMA VERIFIVATION COMPLETE ");
end 
endmodule
