`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 08:35:20 PM
// Design Name: 
// Module Name: UVM_PRAC_BAGIN
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

///////////////////////////////////////////////////////
//////////////////   interface  ///////////////////////
////////////////////////////////////////////////////////

interface alu (input logic clk );
logic       rst;
logic [1:0] op;    // 00: ADD, 01: SUB, 10: AND, 11: OR
logic [3:0] a;
logic [3:0] b;
logic [4:0] result;
endinterface


/////////////////////////////////////////////////
/////////////   sequence  ///////////////////////
//////////////////////////////////////////////////
class aluseq extends uvm_sequence_item ;
`uvm_object_utils (aluseq)

function new(string name = "auseq");
super.new(name);
endfunction 

rand bit rst ;
rand bit [1:0] op;
rand bit [3:0] a ;
rand bit [3:0] b ;
logic [4:0] result ;

endclass 

///////////////////////////////////////////////////////
/////////////////////// sequencer  /////////////////////
///////////////////////////////////////////////////////

class aluseqr extends uvm_sequencer #(aluseq);
`uvm_object_utils(aluseqr)

aluseq a1 ;

function new(string name = "aluseqr");
super.new(name);
endfunction 

task body ();
repeat (5) begin 
start_item(a1);
   a1 = aluseq::type_id::create("a1");
  start_item(a1);
    assert (a1.randomize());
  finish_item(a1);
`uvm_info("item randomized at = %t ",$time,UVM_LOW);
end
endtask 
endclass  
 
////////////////////////////////////////////////////////
//////////////////////  driver  /////////////////////////
/////////////////////////////////////////////////////////

class aludrv extends uvm_driver #(aluseq);
`uvm_component_utils (aludrv)

function new(string name = "aludrv", uvm_component parent = null );
super.new(name, parent );
endfunction 

virtual alu vif ;

virtual function void build_phase (uvm_phase phase ) ;
super.build_phase (phase) ;
                 if(!uvm_config_db#(virtual alu )::set(this,"","vif",vif)) begin 
                    `uvm_fatal("FATAL ERROR OCCURED ", "NO DATA FOUND ");  end 
                  else 
                    `uvm_info ("DATA FOUND AT DRIVER ", "EVERYTHING IS OKEY ", UVM_LOW);
                endfunction 
                
  task run_phase(uvm_phase phase );
  forever begin 
    `uvm_info ("driver", "transfering data from the req to VIF ",UVM_LOW); 
                seq_item_port.get_next_item(req);
                 @(posedge vif.clk);
                    vif.a <= req.a ;
                    vif.b <= req.b ;
                    vif.rst <= req.rst;
                    vif.op <= req.op;
                 seq_item_port.item_done();
             end 
         endtask 
       endclass
       
////////////////////////////////////////////////////////////////////
////////////////// monitoro  /////////////////////////////////////
///////////////////////////////////////////////////////////////////

class alumon extends uvm_monitor ;
`uvm_component_utils (alumon)

virtual alu vif ;
uvm_alanlysis_port #(aluseq) port;
aluseq s1 ;

function new(string name = "alumon", uvm_component parent = null ) ;
super.new(name, parent );
endfunction 

virtual function void build_phase(uvm_phase phase );
super.build_phase (phase ) ;
        if (!uvm_config_db#(virtual alu)::get(this ,"","vif",vif))begin 
          `uvm_fatal("monitor ", "fatal error occured at monitor ");
          end 
          else 
           `uvm_info ("monitro " , "EVERYTHING IS OK AT MONITOR " , UVM_LOW);
           
    endfunction 
  
task run_phase (uvm_phase phase) ;
forever begin 
   s1 = aluseq::type_id::create("s1");
     @(posedge vif.clk );
       s1.a = vif.a ;
       s1.b = vif.b ;
       s1.rst = vif.rst ;
       s1.op = vif.op;
       s1.result = vif.result ;
    port.write(s1);
 `uvm_info ("MONITOR :",$sformatf("monitor - a = %d , b = %d , op = %d , rst = %d ,",vif.a , vif.b , vif.op , vif.rst ),UVM_LOW);
   end 
 endtask 
 endclass 
 
///////////////////////////////////////////////////////
//////////////////////   scoreboard   ///////////////////////
/////////////////////////////////////////////////////


module UVM_PRAC_BAGIN(

    );
endmodule
