`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2026 07:42:22 AM
// Design Name: 
// Module Name: UVM_CODE1_TOP
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

class crypto_packet extends uvm_sequence_item;
`uvm_object_utils(crypto_packet)
function new(string name = "crypto_packet");
super.new(name);
endfunction 
endclass 

class crypto_scoreboard extends uvm_scoreboard ;
`uvm_component_utils (crypto_scoreboard)
function new(string name = "crypto_scoreboard" , uvm_component parent = null);
super.new(name , parent);
endfunction 
endclass 

module UVM_CODE1_TOP;
initial begin
    $display("If this prints, your UVM file structure is perfect!");
    `uvm_info("SUCCESS_TAG", "If this prints, your UVM file structure is perfect!", UVM_NONE)
  end
endmodule
