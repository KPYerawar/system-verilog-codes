`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2026 02:17:56 PM
// Design Name: 
// Module Name: CODE21_MUX_TOP
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
class muxdriver1 ;
  virtual CODE21_MUX_INERFACE vif ;
  
  function new(virtual CODE21_MUX_INERFACE v );
    vif = v ;
  endfunction 
   
  task run();
    vif.in0 = 0 ;
    vif.in1 = 1 ;
     
    vif.sel = 0 ;
    #5;
    $display (" output expected = 0 , actual = %d at time %t " , vif.y ,$time );
    vif.sel = 1 ;
    #5;
    $display (" output expected = 1 , actual = %d at time %t " , vif.y ,$time );
  endtask 
endclass 

module CODE21_MUX_TOP;
  CODE21_MUX_INERFACE intf();

  CODE21_MUX2X1 dut (
    .in0(intf.in0),
    .in1(intf.in1),
    .sel(intf.sel),
    .y(intf.y)
  );

  muxdriver1 drv ;
  
  initial begin 
    drv = new(intf);
    drv.run();
  end 
endmodule