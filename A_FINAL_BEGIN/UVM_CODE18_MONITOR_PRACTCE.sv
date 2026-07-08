`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2026 07:58:48 PM
// Design Name: 
// Module Name: UVM_CODE18_MONITOR_PRACTCE
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

import  uvm_pkg::*;
`include "uvm_macros.svh"

interface my_if18 (input logic clk);
logic [7:0] data ;
logic data_valid;
endinterface 

class my_driver18 extends my_driver;
`uvm_component_utils(my_driver18)

virtual my_if18 vif ;

function new(string name = "my_driver18",uvm_component parent = null );
super.new(name ,parent);
endfunction 

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
              if (!uvm_config_db#(virtual my_if18)::get(this,"","vif",vif)) begin
                  `uvm_fatal("UVM ERROR","DATABASE NOT FOUND ");
               end
               else begin 
                 `uvm_info("DATA FOUND"," ",UVM_LOW);
                 end 
                 endfunction 
             
           task run_phase(uvm_phase phase);
                 phase.raise_objection(this);
                    `uvm_info("TASK STARTED "," ",UVM_LOW);
                    
             @(posedge vif.clk); begin 
                   vif.data <= 8'hab ;
                   vif.valid <= 1 ;
                   end 
            #50 ;
               vif.valid <= 0 ;
           `uvm_info("TASK ENDED"," ",UVM_LOW);
           phase.drop_objection(this);
           endtask 
         endclass 
           
class my_monitor18 extends uvm_monitor ;
  `uvm_component_utils(my_monitor18)

virtual addr_if18 vif ;

  function new(string name = "my_monitor18" , uvm_component parent = null ) ;
  super.new(name, parent );
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
                 if(!uvm_config_db#(virtual addr_if18)::get(this, "", "vif", vif ))begin 
                     `uvm_fatal("DATA NOT FOUND","MOINTOR FATAL");
                     end 
                  else begin 
                     `uvm_info("UVM MONITRO FOUND ","MONITRO FOUND DATA ",UVM_LOW);
                     end
                   endfunction 
                 task run_phase(uvm_phase phase);
                    forever begin 
                      @(posedge vif.clk);
                         if(vif.valid == 1 ) begin 
                            `uvm_info ("MON READING " , "DATA MAY PRINTED ", UVM_LOW );
                            end end
                          endtask 
                       endclass 

module UVM_CODE18_MONITOR_PRACTCE;
my_driver18 d1;
my_monitor18 m1;
bit clk;
always #10 clk = ~clk;
my_if18 inf(clk);

initial begin 
      d1 = my_driver18::type_id::create("d1",null);
      m1 = my_monitor18::type_id::create("m1",null);
      
      uvm_config_db#(virtual my_if18)::set(null,"*","vif",inf);
      run_test();
      end
endmodule
