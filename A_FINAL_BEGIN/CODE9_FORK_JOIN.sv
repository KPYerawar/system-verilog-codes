`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 02:09:54 PM
// Design Name: 
// Module Name: CODE9_FORK_JOIN
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


module CODE9_FORK_JOIN;
initial begin 
$display ("code execution statrt %t",$time);
$display ("2nd line code execution statrt %t",$time);
fork
  $display ("code line 1 inside fork  execution statrt %t",$time);
  #30;
    $display ("code line 2 inside fork  execution statrt %t",$time);
join 
  $display ("code execution statrt %t",$time);
  #20;
$display ("2nd line code execution statrt %t",$time);

end
endmodule
