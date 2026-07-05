`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 11:36:33 AM
// Design Name: 
// Module Name: UVM_CODE14_INTERFACE_INTRO
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

/*
 we will care the interface 1st here 
 ///////////////////////////////////////////////*/
 
 interface my_if14(input logic clk );
 logic [7:0] data ;
 endinterface 
 
 //////////////////////////////////////////             
 //           driver                     //
 /////////////////////////////////////////
 class my_driver14 extends uvm_driver ;
 `uvm_component_utils (my_driver14)
 virtual my_if14 vif;
 
 function new(string name = "my_driver14" , uvm_component parent = null );
 super.new(name , parent ) ;
 endfunction 
 
 virtual function  void build_phase(uvm_phase phase );
 super.build_phase(phase);
 
    if (!uvm_config_db#(virtual my_if14)::get(this , "","vif", vif ))begin 
                  `uvm_fatal("NO_VIF", "DRIVER DIDNT FOUND THE DAABASE ");
                  end 
                  endfunction 
 
 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
             `uvm_info("INTERFACE IS IN CHECKING " , "RUNNING THE TASK ", UVM_LOW);
             @(posedge vif.clk);
             vif.data <= 8'hf;
     #50;
              `uvm_info("THE CLK IS GIVEN " , " AND THE DATA VALUE IS ASSIGNED ", UVM_LOW );
           phase.drop_objection(this);
           endtask 
           endclass 
        
module UVM_CODE14_INTERFACE_INTRO;
my_driver14 d1;
bit clk ;
    always #5 clk = ~clk;
    my_if14 inf(clk);
    initial begin 
    d1  = my_driver14::type_id::create("d1",null);
    
    uvm_config_db#(virtual my_if14)::set(null , "*" , "vif" , inf);
    run_test();
    end 
    
endmodule
