`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 06:47:00 PM
// Design Name: 
// Module Name: UVM_CODE11_UVM_PHASE
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

class my_driver11 extends uvm_driver;
`uvm_component_utils (my_driver11)
function new(string name = "my_driver11" , uvm_component parent = null);
super.new(name,parent);
endfunction 

task run_phase(uvm_phase phase);
phase.raise_objection(this);
`uvm_info ( "run phase" , " we are in task ", UVM_LOW);
phase.drop_objection(this);
endtask 
endclass 



module UVM_CODE11_UVM_PHASE;
my_driver11 d1 ;
initial begin 
`uvm_info("we arw in the initial begin task is not clled yet ","and objesct is not creted ",UVM_LOW);
d1 = my_driver11::type_id::create("d1",null);
`uvm_info("object created and hope cunstructr willl called","uvm called",UVM_LOW);
run_test();
end 

endmodule
