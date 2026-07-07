`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2026 06:22:11 PM
// Design Name: 
// Module Name: UVM_CODE17_MONITOR
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

interface addr_if17 (input logic clk );
logic addr_valid;
endinterface 

class my_driver17 extends uvm_driver ;
`uvm_component_utils(my_driver17)

virtual addr_if17 vif ;

function new(string name =  "my_driver17" , uvm_component parent = null);
super.new(name, parent);
endfunction 

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
            if (!uvm_config_db#(virtual addr_if17)::get(this,"","vif", vif) ) begin 
                       `uvm_fatal("FATAL ERROR","DATABASE NT FOUND");
                       end 
                   endfunction 
             task run_phase(uvm_phase phase ) ;
                        phase.raise_objection(this ) ;
                             `uvm_info("TASK HAS STARTED"," WAITING FOR CLK", UVM_LOW );
                                  @(posedge vif.clk) 
                                        vif.addr_valid <= 1;
                                 #50;
                                vif.addr_valid <= 0 ;
                                       
                                   `uvm_info("data has been assigned ", " click was given ", UVM_LOW);
                             phase.drop_objection(this);
                           endtask 
                           endclass

class my_monitor17 extends uvm_monitor ;
`uvm_component_utils(my_monitor17)

virtual addr_if17 vif ;

  function new(string name = "my_monitor17" , uvm_component parent = null ) ;
  super.new(name, parent );
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
                 if(!uvm_config_db#(virtual addr_if17)::get(this, "", "vif", vif ))begin 
                     `uvm_fatal("DATA NOT FOUND","MOINTOR FATAL");
                     end 
                  else begin 
                     `uvm_info("UVM MONITRO FOUND ","MONITRO FOUND DATA ",UVM_LOW);
                     end
                   endfunction 
                 task run_phase(uvm_phase phase);
                    forever begin 
                      @(posedge vif.clk);
                         if(vif.addr_valid == 1 ) begin 
                            `uvm_info ("MON READING " , "DATA MY PRINTED ", UVM_LOW );
                            end end
                          endtask 
                       endclass 
                                               

module UVM_CODE17_MONITOR;
   bit clk ;
   always #5 clk = ~clk;
   addr_if17 inf(clk);
      my_driver17 d1 ;
      my_monitor17 m1;
      
      initial begin 
           `uvm_info (" INITIAL BEGIN 1","OBJECT INSTATTIONTION STARTED ",UVM_LOW);
              d1 = my_driver17::type_id::create("d1",null);
              m1 = my_monitor17::type_id::create("m1", null);
              
              uvm_config_db#(virtual addr_if17)::set(null, "*", "vif", inf);
            `uvm_info("INITIAL BEGIN 2 ","OBJECT MADE AND THE DATABASE PASSED",UVM_LOW);
            run_test();
            end 
endmodule
