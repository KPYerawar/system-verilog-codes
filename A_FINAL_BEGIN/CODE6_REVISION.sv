`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 01:36:44 PM
// Design Name: 
// Module Name: CODE6_REVISION
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

class  packetcounter ;
 int sentcounter ;
 int dropcounter;
 function void process_packets( bit is_valid );
   if (is_valid == 1 )
      sentcounter = sentcounter+1;
   else 
      dropcounter = dropcounter +1 ;
  endfunction 
  function void stats_show ();
     $display ("total packet sent = %d , total packed droped = %d", sentcounter , dropcounter );
     endfunction
  endclass
  
module CODE6_REVISION;
packetcounter p1 ;
initial begin 
p1 = new();
p1.process_packets(1);
#10;
p1.process_packets(0);
#10;
p1.process_packets(1);
#10;
p1.process_packets(0);
#10;
p1.process_packets(0);
#10;
p1.stats_show();
end 

endmodule
