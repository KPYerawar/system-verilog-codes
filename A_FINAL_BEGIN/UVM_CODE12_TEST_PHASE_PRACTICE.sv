`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 09:39:42 AM
// Design Name: 
// Module Name: UVM_CODE12_TEST_PHASE_PRACTICE
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

class my_driver12 extends uvm_driver;
`uvm_component_utils(my_driver12)

function new(string name = "my_driver12" ,  uvm_component parent = null);
super.new(name,parent);
endfunction 

task run_phase(uvm_phase phase);
phase.raise_objection(this );
`uvm_info("UVM TASK IS RUNNING " , " WE ARE IN TASK " , UVM_LOW);
phase.drop_objection(this);
endtask 
endclass 

module UVM_CODE12_TEST_PHASE_PRACTICE;
my_driver12 d1 ;
initial begin 
d1 = my_driver12::type_id::create("d1",null);
run_test();
end 
endmodule
