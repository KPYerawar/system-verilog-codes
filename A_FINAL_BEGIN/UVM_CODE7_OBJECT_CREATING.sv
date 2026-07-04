`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 11:14:03 AM
// Design Name: 
// Module Name: UVM_CODE7_OBJECT_CREATING
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
import uvm_pkg::*;
`include "uvm_macros.svh"

class my_driver9 extends uvm_driver ;
`uvm_component_utils(my_driver9)

function new ( string name = "my_driver9" , uvm_component parent = null );
   super.new( name , parent );
   endfunction 
 
 task run();
     `uvm_info("DRV" , " the driver is working " , UVM_LOW)
     endtask 
  endclass 
  

module UVM_CODE7_OBJECT_CREATING;
my_driver9 d1 ;
initial begin 
d1 = my_driver9::type_id::create("d1" , null );
d1.run();
end 

endmodule
