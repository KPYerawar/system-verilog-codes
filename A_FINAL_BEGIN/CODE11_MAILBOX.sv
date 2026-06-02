`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 02:47:27 PM
// Design Name: 
// Module Name: CODE11_MAILBOX
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



module CODE11_MAILBOX;
int received;

mailbox mbx;
initial begin 
mbx = new();
fork 
begin 
  $display ("sender is sending data at %t ", $time );
  #20;
  mbx.put(200);
  $display ("after 20  s delay sender sent at time %t ", $time );
  end 
  
begin 
$display ("receiver is reay at %t timr " , $time );
mbx.get(received);
$display ("i got the data at %t is %d ", $time , received );
end 
join 
end 
endmodule