`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 05:37:50 PM
// Design Name: 
// Module Name: UVM_CODE15_INTERFACE_PRACTICE
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



interface my_if15 (input logic clk );
logic [7:0] data ;
endinterface


class my_driver15 extends uvm_driver ;
`uvm_component_utils(my_driver15)
virtual my_if15 vif;

function new (string name = "my_driver15" , uvm_component parent = null );
super.new(name , parent );               
endfunction 



virtual function void build_phase(uvm_phase phase  );
super.build_phase(phase);

                                                if ( !uvm_config_db#(virtual my_if15)::get(this , "" , "vif" , vif )) begin 
                `uvm_fatal ("no vif found"," system failed , database not found ");
                end 
                
endfunction 

task run_phase (uvm_phase phase ) ;
phase.raise_objection(this ) ;
              @(posedge vif.clk ) 
                    vif.data <= 8'h100;
                    #50;
                    
               `uvm_info ("DATA ASSIGNED " , " CLK IS GIVEN VIA VIRTUAL " , UVM_LOW);
        phase.drop_objection(this );
     endtask 


endclass 



module UVM_CODE15_INTERFACE_PRACTICE;
bit clk ;
my_driver15 d1;
always #5 clk = ~clk;
my_if15 inf(clk);

 initial begin 
        `uvm_info("INITIAL BEGIN " , " GOING TO MAKE OBJECT " , UVM_LOW );
           d1 = my_driver15::type_id::create("d1", null );
           
           uvm_config_db#(virtual my_if15)::set(null , "", "vif", inf);
         `uvm_info ("task created and passed ", " " , UVM_LOW);
         end  
endmodule
