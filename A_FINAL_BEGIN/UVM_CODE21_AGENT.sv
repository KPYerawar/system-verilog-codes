`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2026 09:15:52 PM
// Design Name: 
// Module Name: UVM_CODE21_AGENT
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

interface my_if21 (input logic clk);
logic data ;
logic data_valid ;
endinterface 

/////////////////////////////////////
///// driver ///////////////////////
///////////////////////////////////

class my_driver21 extends uvm_driver ;
`uvm_component_utils (my_driver21)

virtual my_if21 vif  ;

function new(string name = "my_driver21", uvm_component parent = null);
   super.new(name , parent );
 endfunction 
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  
       if (!uvm_config_db#(virtual my_if21)::get(this, "","vif",vif)) begin 
           `uvm_fatal("DATA ERROR ","DATA NOT FOUND ");
          end 
        else begin
           `uvm_info ("DATA FOUND "," ",UVM_LOW);
           end 
       endfunction 
     
     task run_phase(uvm_phase phase );
         phase.raise_objection (this);
             @(posedge vif.clk); 
             begin 
                vif.data <= 1;
                vif.data_valid <= 1;
                end 
          #50;
             vif.data_valid <= 0 ;
          `uvm_info("DATA ASSIGNED" , "GETTING OUT FROM THE TASK",UVM_LOW);
        phase.drop_objection(this);
      endtask 
    endclass 
     
     class my_monitor21 extends uvm_monitor;
     `uvm_component_utils(my_monitor21)
     virtual my_if21 vif;
           function new(string name = "my_monitor21",uvm_component parent = null);
              super.new(name,parent);
              endfunction 
              
              virtual function void build_phase(uvm_phase phase);
              super.build_phase(phase);
                  if(!uvm_config_db#(virtual my_if21)::get(this,"","vif",vif))begin 
                     `uvm_fatal("UVM ERROR","DATA NOT FOUND");
                   end 
                endfunction 
         task run_phase(uvm_phase phase);
             forever begin 
                @(posedge vif.clk);
                   if(vif.data_valid ==1 ) begin 
                       `uvm_info("VALID = 1 ","IT IS WORKING " , UVM_LOW );
                       end 
                   end 
                 endtask 
                 endclass 
                
////////////////   agent ////////////////////
class my_agent21 extends uvm_agent ;
`uvm_component_utils (my_agent21)

virtual my_if21 vif;
  my_driver21 driver21;
  my_monitor21 monitor21;
  
   function new(string name = "my_agent",uvm_component parent = null);
     super.new(name , parent );
     endfunction 
   
   virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
     
     driver21 = my_driver21::type_id::create("driver21",null);
     monitor21 = my_monitor21::type_id::create("monitor21",null);
     endfunction 
     endclass 
     
   
                
module UVM_CODE21_AGENT;
bit clk ;
always #10 clk = ~clk;
my_if21 inf(clk);
my_agent21 agent21;
initial begin 
   uvm_config_db#(virtual my_if21)::set(null,"*","vif",inf);
   agent21 = my_agent21::type_id::create("agent21",null);
   run_test();
   end
endmodule
