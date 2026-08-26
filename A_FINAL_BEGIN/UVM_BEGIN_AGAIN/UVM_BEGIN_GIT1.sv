`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2026 09:26:32 PM
// Design Name: 
// Module Name: UVM_BEGIN_GIT1
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
Implementation Requirements
Transaction Item (comp_packet):
Inputs: rand bit rst;, rand bit [3:0] a;, rand bit [3:0] b;
Outputs: bit greater;, bit equal;, bit less;
Constraint: Keep rst active with a low probability (e.g., rst dist {1 := 1, 0 := 9};).
Sequence (comp_sequence):
Generate at least 15 transactions to exercise different comparison combinations.
Interface (comp_if):
Bundle clk, rst, a, b, greater, equal, and less.
Driver (comp_driver):
Fetch item from sequencer, wait for @(posedge vif.clk), drive rst, a, and b, and complete with item_done().
Monitor (comp_monitor):
Sample a, b, rst, greater, equal, and less at @(posedge vif.clk).
Broadcast the sampled transaction using uvm_analysis_port.
Scoreboard (comp_scoreboard):
Check logic:
If pkt.rst == 1: Expect greater == 0, equal == 0, less == 0.
If pkt.rst == 0:
a > b $\rightarrow$ Expect greater == 1, others 0.
a == b $\rightarrow$ Expect equal == 1, others 0.
a < b $\rightarrow$ Expect less == 1, others 0.
Print PASS or FAIL using `uvm_info / `uvm_error.
Agent, Env, Test, and Top Module:
Instantiate DUT, connect interface, set config DB, and invoke run_test().
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

///////////////////////////////////////////////////////////////
//////////////////    interface ///////////////////////////////
////////////////////////////////////////////////////////////////

interface inf1 (input logic clk ) ;
logic rst ;
logic [3:0] a ;
logic [3:0] b ;
logic greater ;
logic less ;
logic equal ;
endinterface 

////////////////////////////////////////////////////////////////////
//////////////////////////   packets ///////////////////////////////
//////////////////////////////////////////////////////////////////////

class pkt1 extends uvm_sequence_item ;
`uvm_object_utils (pkt1) 

function new(string name = "pkt1");
super.new(name) ;
endfunction 

rand bit [3:0] a ;
rand bit [3:0] b;
rand bit rst ;
bit greater;
bit less ;
bit equal ;

constraint cons1 {
rst dist { 1:= 10 , 0 := 90 };}

endclass 

//////////////////////////////////////////////////////////////////////
////////////////////////////////   randomization ///////////////////////
/////////////////////////////////////////////////////////////////////////////

class trans1 extends uvm_sequence #(pkt1);
`uvm_object_utils(trans1)

function new (string name = "trans1");
super.new(name);
endfunction 

pkt1 p1 ;
task body ();
repeat (15 ) begin 
 p1 = pkt1::type_id::create("p1");
  start_item(p1);
     assert (p1.randomize());
   finish_item(p1);
 `uvm_info ("RANDMIZING THE PACKET ","",UVM_LOW);
 
 end 
 endtask 
 endclass 
 
 /////////////////////////////////////////////////////////////////////
 ///////////////////////// driver //////////////////////////////////
 //////////////////////////////////////////////////////////////////
 
 class drv1 extends uvm_driver #(pkt1);
 `uvm_component_utils (drv1)
 
 function new(string name ="drv1",uvm_component parent = null ) ;
 super.new(name, parent );
 endfunction 
 
 virtual inf1 vif ;
 
 virtual function void build_phase (uvm_phase phase ) ;
 super.build_phase(phase);
     if (!uvm_config_db#(virtual inf1)::get(this,"","vif",vif)) begin 
         `uvm_fatal("FATAL ERROR OCCURED ","STOP CODE ");
        end 
       else 
            `uvm_info ( "DATA FOUND FOR THE DRIVER ","",UVM_LOW);
        endfunction 
  
 task run_phase (uvm_phase phase  ) ;
 forever begin 
        seq_item_port.get_next_item(req);
          @(posedge vif.clk);
            vif.a <= req.a ;
            vif.b <= req.b;
            vif.rst <= req.rst;
         seq_item_port.item_done();
       end 
   endtask 
 endclass 
 
 ////////////////////////////////////////////////////////////////////////
 //////////////////////////  monitor /////////////////////////////////////
 //////////////////////////////////////////////////////////////////////
 
 class mon1 extends uvm_monitor ;
 `uvm_component_utils (mon1)
 
 virtual inf1 vif ;
 uvm_analysis_port #(pkt1)p1 ;
 
 function new(string name = "mon1",uvm_component parent = null);
 super.new(name , parent ) ;
 endfunction 
 
 
 virtual function void build_phase (uvm_phase phase ) ;
 super.build_phase(phase);
  p1 = new("p1",this);
     if (!uvm_config_db#(virtual inf1)::get(this,"","vif",vif)) begin 
         `uvm_fatal("FATAL ERROR OCCURED ","STOP CODE ");
        end 
       else 
            `uvm_info ( "DATA FOUND FOR THE MONITOR ","",UVM_LOW);
        endfunction 
 
 
task run_phase (uvm_phase phase );
pkt1 pkt ;
forever begin 
             @(posedge vif.clk ) ;
             pkt = pkt1::type_id::create("pkt");
             pkt.a = vif.a ;
             pkt.b = vif.b ;
             pkt.rst = vif.rst ;
             pkt.greater = vif.greater ;
             pkt.less = vif.less ;
             pkt.equal = vif.equal ;
         p1.write(pkt);
         `uvm_info("MONITOR", $sformatf("data =>  a = %d , b = %d , rst = %d , greater = %d , less = %d , equal = %d", vif.a , vif.b , vif.rst , vif.greater , vif.less , vif.equal), UVM_LOW);
            end 
        endtask 
     endclass 
  
      /////////////////////////////////////////////////////////////////////////
      /////////////////////////////// scoreboard ////////////////////////////
      ////////////////////////////////////////////////////////////////////////////
      
      class sco1 extends uvm_scoreboard ;
      `uvm_component_utils (sco1)
      
      uvm_analysis_imp #(pkt1,sco1) exp_imp ;
      
      function new(string name = "sco1",uvm_component parent = null ) ;
      super.new(name , parent );
      endfunction 
      
      virtual function void build_phase (uvm_phase phase ) ;
      super.build_phase (phase) ;
          exp_imp = new("exp_imp", this);
        endfunction 
       
       virtual function void write(pkt1 p1 ) ;
        bit exp_greater;
    bit exp_equal;
    bit exp_less;

    if (p1.rst) begin
      exp_greater = 0;
      exp_equal   = 0;
      exp_less    = 0;
    end else begin
      exp_greater = (p1.a > p1.b);
      exp_equal   = (p1.a == p1.b);
      exp_less    = (p1.a < p1.b);
    end
         
        if ((p1.greater === exp_greater) && (p1.equal === exp_equal) && (p1.less === exp_less)) begin
      `uvm_info("SCOREBOARD_PASS", $sformatf("MATCH! a=%0d b=%0d rst=%0b | greater=%0b equal=%0b less=%0b", 
                p1.a, p1.b, p1.rst, p1.greater, p1.equal, p1.less), UVM_LOW);
    end else begin
      `uvm_error("SCOREBOARD_FAIL", $sformatf("MISMATCH! a=%0d b=%0d rst=%0b | Expected(G=%0b,E=%0b,L=%0b) != Actual(G=%0b,E=%0b,L=%0b)", 
                 p1.a, p1.b, p1.rst, exp_greater, exp_equal, exp_less, p1.greater, p1.equal, p1.less));
    end
  endfunction
         endclass 
      
  
  ///////////////////////////////////////////////////////////////////////////
  ////////////////////////// agent ///////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  
  class age1 extends uvm_agent;
  `uvm_component_utils (age1)
  
  function new(string name ="age1",uvm_component parent = null ) ;
 super.new(name , parent ) ;
 endfunction 
 
 mon1 m1 ;
 drv1 d1 ;
 trans1 t1 ;
 
 virtual function void build_phase (uvm_phase phase);
 super.build_phase (phase);
          m1 = mon1::type_id::create("m1",this);
          d1 = drv1::type_id::create("d1",this);
          t1 = trans1::type_id::create("t1",this);
      endfunction 
      
     virtual  function void  connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d1.seq_item_port.connect(t1.seq_item_export);
      endfunction 
   endclass 
   
   
 //////////////////////////////////////////////////////////////////////
 /////////////////////  env /////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////
 
 class env1 extends uvm_env ;
 `uvm_component_utils(env1)
 
 function new(string name = "env1",uvm_component parent = null );
 super.new(name , parent );
 endfunction 
 
 age1 a1 ;
 sco1 s1 ;
 
 virtual function void build_phase (uvm_phase phase );
 super.build_phase (phase) ;
    a1 = age1::type_id::create("a1",this);
    s1 = sco1::type_id::create("s1",this);
 endfunction 
 
 virtual function void connect_phase (uvm_phase phase );
 super.connect_phase (phase) ;
      a1.m1.ap.connect(s1.exp_imp);
      endfunction 
 endclass 
 
 
 /////////////////////////////////////////////////////////////////////
 ///////////////////////   test /////////////////////////////////
 //////////////////////////////////////////////////////////////////////
 
 class test1 extends uvm_test ;
 `uvm_component_utils(test1)
 
 env1 e1 ;
 trans1 t1 ;
 
 function new(string name = "test1",uvm_component parent = null );
 super.new(name , parent );
 endfunction 
 
 
 virtual function void build_phase (uvm_phase phase );
 super.build_phase (phase);
    e1 = env1::type_id::create("e1",this);
    t1 = trans1::type_id::create("t1");
 endfunction 
 
 endclass 
 
 task run_phase (uvm_phase phase);
 phase.raise_objection (this) ;
 s1.start(e1.a1.p1);
 phase.drop_objection(this);
 endtask 
 
 /////////////////////////////////////////////////////////////////////////
 ///////////////////////////////// module ///////////////////////////////
 ///////////////////////////////////////////////////////////////////////
 
 
module UVM_BEGIN_GIT1;
test1 t1 ;
bit clk ;
always #5 clk = ~clk ;
inf1 inf(clk);

comparator_4bit dut (
    .clk     (inf.clk),
    .rst     (inf.rst),
    .a       (inf.a),
    .b       (inf.b),
    .greater (inf.greater),
    .equal   (inf.equal),
    .less    (inf.less)
  );
  
  
initial begin 
     uvm_config_db#(virtual inf1)::set(null , "*","vif",inf);
     run_test("test1");
     end 
endmodule
