`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2026 02:01:57 PM
// Design Name: 
// Module Name: CODE16_CHALLANGE
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



class networkpacket;
    rand bit [7:0] data ;
    bit [7:0] checksum ;
    function void calc_sum();
      checksum = data + 10;
      endfunction 
      endclass 
      
      class router ;
      mailbox mbx ;
      function new(mailbox m );
      mbx = m ;
      endfunction 
      
      task run ();
      networkpacket p1;
      
      repeat (3) begin 
      p1 = new ();
      p1.randomize();
      p1.calc_sum();
      mbx.put(p1);
      #5;
      end
      endtask endclass
      
      class server;
      networkpacket p1;
      mailbox mbx ;
      function new (mailbox m );
      mbx = m ;
        endfunction 
        
      task run();
      repeat (3) begin 
        mbx.get (p1);
        #20;
        $display (" time = %t , data = %d , checksum = %d " , $time , p1.data , p1.checksum );
        end 
        endtask 
        endclass 
        
      
module CODE16_CHALLANGE;
mailbox mbx ;
router r1 ;
server s1 ;
initial begin 

mbx = new();
r1 = new(mbx);
s1 = new(mbx);

fork 
  r1.run();
  s1.run();
  join 
  $display ("simulation completed ");
  end 
  


endmodule
