`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 10:09:11 AM
// Design Name: 
// Module Name: UVM_CODE13_TASK_DELAY
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

class my_driver13 extends uvm_driver;
`uvm_component_utils(my_driver13)

function new(string name = "my_driver13" , uvm_component parent = null);
super.new(name, parent );
endfunction 

task run_phase (uvm_phase phase);
phase.raise_objection (this ) ;
`uvm_info("UVM BEFORE DEALY","UVM TASK1", UVM_LOW);
#200;
`uvm_info("uvm after delay ", "it is running",UVM_LOW);
phase.drop_objection(this);
endtask 
endclass
module UVM_CODE13_TASK_DELAY;
my_driver13 d1;
initial begin 
$display (" initial begin running ");
`uvm_info("INITIAL BEGIN RUNNING ","OBJECT WILL BE CREATED ",UVM_LOW);
d1 = my_driver13::type_id::create("d1", null );
run_test();
`uvm_info("objest is created and tsk is called here ","", UVM_LOW);
end 
endmodule
