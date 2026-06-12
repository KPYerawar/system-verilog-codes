`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2026 08:02:26 AM
// Design Name: 
// Module Name: CODE29_ROUTER_TOP
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

class packet29 ;
rand  bit valid ;
rand bit  [1:0] priority_lvl;
rand bit  [7:0] data_in;

logic [7:0] data_out ;
logic error_flag;

constraint cons1 {
valid dist {
1 := 80 ,
0 := 20 };
}

constraint cons2 {
if (priority_lvl == 3 ) {
          data_in inside {[80:120]};   }
else {
     data_in inside { [10:50]}; } 
     }
 endclass 
 
 
 
 class generator29 ;
     packet29 p1 ;
     mailbox mbx ;
     
     function new(mailbox m ) ;
           mbx = m ;
           endfunction 
           
   task run ();
       repeat(15) begin 
         p1 = new();
         p1.randomize();
         mbx.put(p1) ;
         $display (" packet randomized here ");
         #10;
         end 
         endtask 
         endclass 
         
         
    class driver29 ;
        packet29 p1 ;
        mailbox mbx ;
        virtual CODE29_INTERFACE_ROUTER vif ;
        
    function new (virtual CODE29_INTERFACE_ROUTER v , mailbox m );
           mbx = m ;
           vif = v ;
           endfunction 
        
    task run ();
       repeat (15) begin 
            p1 = new();
            mbx.get(p1);
             
             vif.valid = p1.valid ;
             vif.priority_lvl = p1.priority_lvl;
             vif.data_in = p1.data_in ;
             #10;
             end 
             endtask 
             endclass 
             
      class monitor29 ;
      virtual  CODE29_INTERFACE_ROUTER vif ;
      packet29 p1 ;
      mailbox mbx ;
      
      function new(virtual CODE29_INTERFACE_ROUTER v , mailbox m );
         vif = v ;
         mbx = m ;
         endfunction 
         
      task run();
      repeat(15) begin 
      #10;
         p1 = new();
         
         p1.data_out  = vif.data_out  ;
          p1.error_flag = vif.error_flag  ;
          
          mbx.put(p1);
          
       $display (" at [%0t] data_in = %d data_out = %d , error_flag = %d " , $time , p1.data_in , p1.data_out , p1.error_flag );
       end 
       endtask 
       endclass 
       
        
         
    
      
module CODE29_ROUTER_TOP;

CODE29_INTERFACE_ROUTER intf();
CODE29_PRIORITY_ROUTER r1 (
.valid(intf.valid),.data_in(intf.data_in),.priority_lvl(intf.priority_lvl),.data_out(intf.data_out),.error_flag(intf.error_flag));


generator29 gen1;
driver29 drv1;
mailbox mbx1 ;
mailbox mbx2;
monitor29 m1 ;
initial begin 
mbx1 = new();
mbx2 = new();
gen1 = new(mbx1);
drv1 = new(intf , mbx1);
m1 = new(intf, mbx2);
fork 
  gen1.run();
  drv1.run();
  m1.run();
  join 
  
  $display (" sv verifivation completed ");
  end
  
endmodule
