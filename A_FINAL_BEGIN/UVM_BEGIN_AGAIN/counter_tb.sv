`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2026 09:17:50 PM
// Design Name: 
// Module Name: counter_tb
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
/*

module counter_4bit (
    input  logic       clk,
    input  logic       rst,      // Active-high synchronous reset
    input  logic       load,     // Active-high load
    input  logic       en,       // Active-high count enable
    input  logic       up_down,  // 1: Up count, 0: Down count
    input  logic [3:0] data_in,  // Parallel load data
    output logic [3:0] count     // 4-bit counter output
);

  always_ff @(posedge clk) begin
    if (rst) begin
      count <= 4'b0000;
    end else if (load) begin
      count <= data_in;
    end else if (en) begin
      if (up_down)
        count <= count + 1'b1;
      else
        count <= count - 1'b1;
    end
  end

endmodule
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

//////////////////////////////////////////////////
//////////////  interface  //////////////////////
/////////////////////////////////////////////////

interface counter (input logic clk ) ;
logic rst;      // Active-high synchronous reset
logic load;     // Active-high load
logic en;       // Active-high count enable
logic up_down;  // 1: Up count, 0: Down count
logic [3:0] data_in;  // Parallel load data
logic [3:0] count;
endinterface  

///////////////////////////////////////////////////////
//////////////  sequence  ///////////////////////////
/////////////////////////////////////////////////////

class conseq extends uvm_sequence_item  ;
`uvm_object_utils (conseq)

function new(string name = "conseq");
super.new(name);
endfunction 

rand bit rst ;
rand bit load ;
rand bit en ;
rand bit up_down ;
rand bit [3:0] data_in ;
logic [3:0] count ;

constraint cons1 {
rst dist { 1:= 10, 0:= 90 };
load dist { 1:= 20 , 0:= 80 };
en dist { 1:= 80 ,0:= 20 };
}

endclass 

/////////////////////////////////////////////////
//////////////////////  sequencer  ///////////////
//////////////////////////////////////////////// 

class conseqr extends uvm_sequence #(conseq) ;
`uvm_object_utils (conseqr );

function new(string name = "conseqr");
super.new(name );
endfunction 

conseq c1 ;

task body();
repeat (5) begin 
  c1 = conseq::type_id::create("c1");
  start_item(c1);
  assert (c1.randomize());
  finish_item(c1);
 end 
endtask 
endclass 

/////////////////////////////////////////////////
///////////////  driver  /////////////////////////
//////////////////////////////////////////////////

class condrv extends uvm_driver #(conseq);
`uvm_component_utils(condrv )

function new(string name = "condrv",uvm_component parent = null );
super.new(name , parent );
endfunction 

virtual counter vif ;

virtual function void build_phase (uvm_phase phase ) ;
super.build_phase(phase);
                    if(!uvm_config_db #(virtual counter)::get(this,"","vif",vif)) begin 
                       `uvm_fatal ("DRIVER","DATA NOT FOUND ");
                       end 
                      else 
                         `uvm_info ("DRIVER " , "DATA FOUND ", UVM_LOW);
             endfunction 
             
 task run_phase (uvm_phase phase) ;
 forever begin 
     seq_item_port.get_next_item  (req);
       @(posedge vif.clk );
          vif.rst = req.rst ;
          vif.en = req.en;
          vif.load = req.load;
          vif.data_in = req.data_in ;
          vif.up_down = req.up_down ;
       seq_item_port.item_done ();
    `uvm_info("DRIVER", "DATA PASSED TO VIF ",UVM_LOW);
  end 
 endtask endclass 
 
 ////////////////////////////////////////////////////////////////
 /////////////////////   monitor //////////////////////////////
 ///////////////////////////////////////////////////////
 
 class conmon extends uvm_monitor ;
 `uvm_component_utils (conmon )
 
 function new(string name = "conmon" , uvm_component parent = null );
 super.new(name , parent );
 endfunction 
 
 uvm_analysis_port #(conseq) port ;
 conseq c1 ;
 virtual counter vif ;
   
 virtual function void build_phase (uvm_phase phase ) ;
 super.build_phase (phase );
    port = new("port",this);
         if(!uvm_config_db #(virtual counter)::get(this,"","vif",vif)) begin 
                       `uvm_fatal ("MONITOR","DATA NOT FOUND ");
                       end 
                      else 
                         `uvm_info ("MONITOR " , "DATA FOUND ", UVM_LOW);
          endfunction 
   
 task run_phase (uvm_phase phase ) ;
 forever begin 
   @(posedge vif.clk);
     c1 = conseq::type_id::create("c1");
          c1.rst = vif.rst;
          c1.en = vif.en ;
          c1.load = vif.load ;
          c1.data_in = vif.data_in ;
          c1.up_down = vif.up_down ;
          c1.count = vif.count ;
     `uvm_info ("MONITOR ", $sformatf("data := rst = %b , en = %b , load = %b , up_down = %b , data_in = %b ", vif.rst , vif.en , vif.load , vif.up_down , vif.data_in ), UVM_LOW);
     port.write(c1);
     end 
   endtask 
 endclass 
 
 
 //////////////////////////////////////////////////////////////
 ///////////////////////   scoreboard  //////////////////////
 /////////////////////////////////////////////////////////////////
  
  class consco extends uvm_scoreboard ;
  `uvm_component_utils(consco)
 
 function new(string name = "consco",uvm_component parent = null );
 super.new(name , parent );
 endfunction 
 
 virtual counter vif ;
 uvm_analysis_imp #(conseq,consco) imp ;
 
 virtual function void build_phase (uvm_phase phase );
 super.build_phase (phase);
    imp = new("imp",this);
 endfunction 
 
 virtual function void write ( conseq s1 );
     bit [3:0] copy_data ;
   if (s1.rst) begin 
     copy_data = 0;
     end 
     else if (s1.load ) begin 
       copy_data = s1.data_in ; end 
      else if (s1.en) begin
       if(s1.up_down) 
          copy_data = copy_data + 1 ;
          else 
            copy_data = copy_data - 1 ;
        end 
     
  if ( copy_data == s1.count ) begin 
    `uvm_info("PASS","",UVM_LOW); end 
    else 
     `uvm_info ("fail","",UVM_LOW);
  endfunction 
  endclass 
  
  
  ///////////////////////////////////////////////////
  /////////////////  agent /////////////////////////
  /////////////////////////////////////////////////
  
  class conage extends uvm_agent;
  `uvm_component_utils (conage )
  
  function new(string name = "conage",uvm_component parent = null ) ;
  super.new(name , parent ) ;
  endfunction 
  
  condrv d1 ;
  conmon m1 ;
  uvm_sequencer #(conseqr) sr ;
  
  virtual function void build_phase (uvm_phase phase ) ;
  super.build_phase (phase);
    d1 = condrv::type_id::create("d1",this ) ;
    m1 = conmon::type_id::create("m1",this );
    sr = conseqr::type_id::create("sr",this) ;
  endfunction 
  
virtual function void connect_phase (uvm_phase phase );
super.connect_phase (phase);
d1.seq_item_port.connect(seqr.seq_item_export);
 `uvm_info ("AGENT","UVM PORT CONNECTION IN WORK ",UVM_LOW);
endfunction 

endclass 

////////////////////////////////////////////////////
//////////////////// env  /////////////////////////
//////////////////////////////////////////////////

class conenv extends uvm_env ;
`uvm_component_utils(conenv)

function new(string name = "conenv",uvm_component parent = null ) ;
super.new(name , parent ) ;
endfunction 

conage a1 ;
consco sc1 ;

virtual function void build_phase (uvm_phase phase ) ;
super.build_phase (phase ) ;
     a1 = conage::type_id::create("a1",this ) ;
     sc1 = consco::type_id::create("sc1",this);
  endfunction 
  
virtual function void   connect_phase (uvm_phase phase  );
super.connect_phase (phase);
a1.m1.port.connect(sc1.imp);
endfunction 


endclass 

/////////////////////////////////////////////////
////////////////////////  test  ///////////////
//////////////////////////////////////////////

class contest extends uvm_test ;
`uvm_component_utils (contest)

function new(string name = "contest",uvm_component parent = null );
super.new(name , parent ) ;
endfunction 

conseqr sr2 ;
conenv e1 ;

virtual function void build_phase (uvm_phase phase ) ;
super.build_phase (phase ) ;
     sr2 = conseqr::type_id::create("sr2",this);
     e1 = conenv::type_id::create("e1",this);
   endfunction 
   
   task run_phase (uvm_phase phase );
      phase.raise_objection(this);
sr2.start(e1.a1.sr);
  phase.drop_objection (this);
  #20;
  endtask 
endclass 

///////////////////////////////////////////////////
//////////////////////////// module  /////////////
/////////////////////////////////////////////

module counter_tb;
bit clk ;
always #5 clk = ~clk ;
counter inf (clk);

counter_4bit con1(
.en(inf.en),.load(inf.load),.rst(inf.rst),.clk(inf.clk),.data_in(inf.data_in),.count(inf.count),.up_down(inf.up_down));

initial begin 
uvm_config_db #(virtual counter )::set(null,"*","vif",inf ) ;
run_test("contest");
end 

endmodule
