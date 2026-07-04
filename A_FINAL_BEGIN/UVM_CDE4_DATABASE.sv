`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 09:54:11 AM
// Design Name: 
// Module Name: UVM_CDE4_DATABASE
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
interface mt_if (input logic clk);
logic [7:0] data ;
endinterface 
class my_driver4 extends uvm_driver ;
`uvm_component_utils(my_driver4)


virtual my_if vif ;
function new( string name = "my_driver4" , uvm_component parent  = null );
super.new(name,parent);
endfunction 

virtual function void build_phase (uvm_phase phase );
super.build_phase(phase);
if (!uvm_config_db#(virtual my_if)::get(this , "" ,"vif" , vif)) begin 
       `uvm_fatal ("NO_VIF" ," didnt found the interface ");
       end 
       endfunction 
       endclass 
 
 
module UVM_CDE4_DATABASE(

    );
endmodule
