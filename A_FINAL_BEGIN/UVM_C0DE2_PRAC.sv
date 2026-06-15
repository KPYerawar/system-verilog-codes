`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2026 05:47:19 AM
// Design Name: 
// Module Name: UVM_C0DE2_PRAC
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
`include "uvm_macros.svh"
import uvm_pkg::*;

class crypto_code2 extends uvm_sequence_item ;
`uvm_object_utils (crypto_code2)
function new (string name = "crypto_code2");
super.new(name);
endfunction 
endclass 

class crypto_sco_code2 extends uvm_scoreboard;
`uvm_component_utils (crypto_sco_code2)
function new(string name = "crypto_sco_code2" , uvm_component parent = null);
super.new(name , parent );
endfunction 
endclass 



module UVM_C0DE2_PRAC;
initial begin 
`uvm_info ("success tag " , " uvm officially begin today",UVM_NONE);
$display (" display ");
end 
endmodule
