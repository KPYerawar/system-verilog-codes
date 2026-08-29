`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2026 10:08:36 AM
// Design Name: 
// Module Name: testbench
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


module mux4to1(
input logic clk ,
input logic rst ,
input logic [1:0] sel ,
input logic [3:0] in0,in1,in2,in3 ,
output logic [3:0] out 
    );
    
    always_ff @(posedge clk )begin 
       if (rst == 1 ) begin 
         out <= 0 ;
       end 
       else begin 
          case(sel) 
              2'b00 : out <= in0 ;
              2'b01 : out <= in1;
              2'b10: out <= in2 ;
              default : out <= in3 ;
          endcase 
        end 
      end 
         
endmodule
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

//////////////////////////////////////////////////////////////////
///////////////////////// interface ////////////////////////////
//////////////////////////////////////////////////////////////

interface mux4to1_inf (input logic clk ) ;
logic rst ;
logic [1:0] sel ;
logic [3:0] in0,in1,in2,in3 ;
logic [3:0] out;
endinterface 

///////////////////////////////////////////////////////////
//////////////////// sequence //////////////////////////
//////////////////////////////////////////////////////////
class mseq extends uvm_sequence_item ;
`uvm_object_utils (mseq)

rand bit [1:0] sel ;
rand bit  [3:0] in0,in1,in2,in3 ;
rand bit  rst ;
logic [3:0] out ;

function new ( string name = "mseq");
super.new(name);
endfunction

endclass 
//////////////////////////////////////////////////////////
///////////////////////  sequencer  //////////////////////
//////////////////////////////////////////////////////////

class mseqr extends uvm_sequence #(mseq);
`uvm_object_utils(mseqr)
mseq m1 ;

function new (string name = "mseqr");
super.new(name);
endfunction 

task body ();
repeat (5) begin 
m1 = mseq::type_id::create("m1");
start_item(m1);
assert (m1.randomize());
finish_item(m1);
end
endtask 
endclass 

///////////////////////////////////////////////////////////////
/////////////////////////  driver /////////////////////////////
//////////////////////////////////////////////////////////////

class mdrv extends uvm_driver #(mseq);
`uvm_component_utils (mdrv);

function new (string name ="mdrv",uvm_component parent =  null );
super.new(name,parent);
endfunction 

virtual mux4to1_inf vif ;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
                  if (!uvm_config_db#(virtual mux4to1_inf)::get(this,"","vif",vif))begin 
                     `uvm_fatal ("FATAL ERROR FOUND ","NO DATA FOUND AT DRIVER");
                    end 
                  else begin 
                     `uvm_info("DRIVER :","FOUND THE DATA ",UVM_LOW);
                     end 
                 endfunction 
     
task run_phase (uvm_phase phase) ;
  forever begin 
       seq_item_port.get_next_item(req);
    @(posedge vif.clk);
           vif.rst <= req.rst ;
           vif.sel <= req.sel ;
           vif.in0 <= req.in0;
           vif.in1 <= req.in1;
           vif.in2 <= req.in2 ;
           vif.in3  <= req.in3 ;
      seq_item_port.item_done();
    end 
  endtask 
endclass 

//////////////////////////////////////////////////////////////////
/////////////////////////  monitor  /////////////////////////////
////////////////////////////////////////////////////////////////

class mmon extends uvm_monitor ;
`uvm_component_utils (mmon)

function new(string name = "mmon",uvm_component parent = null );
super.new(name , parent );
endfunction 

virtual mux4to1_inf vif ;
uvm_analysis_port #(mseq) port;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  port = new("port",this);

                  if (!uvm_config_db#(virtual mux4to1_inf)::get(this,"","vif",vif))begin 
                     `uvm_fatal ("FATAL ERROR FOUND ","NO DATA FOUND AT monitor");
                    end 
                  else begin 
                     `uvm_info("DRIVER :","FOUND THE DATA ",UVM_LOW);
                     end 
 endfunction 

 
 task run_phase (uvm_phase phase ) ;
 mseq m1 ;
   forever begin 
      @(posedge vif.clk);
        m1 = mseq::type_id::create("m1");
        m1.rst = vif.rst;
        m1.sel = vif.sel;
        m1.in0 = vif.in0 ;
        m1.in1 = vif.in1 ;
        m1.in2 = vif.in2;
        m1.in3 = vif.in3 ;
        m1.out = vif.out ;
      port.write(m1);
  `uvm_info ("MONITOR",$sformatf("rst = %b , in0 = %b , in1 = %b , in2 = %b , in3 = %b , sel = %b ",vif.rst, vif.in0 , vif.in1 , vif.in2 , vif.in3 , vif.sel),UVM_LOW);
  end 
 endtask 
 endclass 
 
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////  scoreboard  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

class msco extends uvm_scoreboard ;
`uvm_component_utils (msco)

uvm_analysis_imp #(mseq,msco) imp;

function new(string name = "msco",uvm_component parent = null );
super.new(name , parent );
endfunction 

virtual function void build_phase (uvm_phase phase );
super.build_phase (phase );
   imp = new("imp",this);
 endfunction 
 
 virtual function void write (mseq m1 );
 bit [3:0] imp_out ;
 
 if ( m1.rst) begin 
    imp_out = 0 ;
    end 
  else begin 
     case (m1.sel) 
       2'b00 : imp_out = m1.in0 ;
       2'b01: imp_out = m1.in1 ;
       2'b10 : imp_out = m1.in2 ;
       default : imp_out = m1.in3 ;
    endcase 
        end 
     
     if (m1.out == imp_out) begin 
        `uvm_info("SCOREBOARD","PASS",UVM_LOW);
     end 
    else 
      `uvm_info ("SCOREBOARD","FAIL",UVM_LOW);
    endfunction 
endclass 

///////////////////////////////////////////////////////////////////////
/////////////////////  agent  /////////////////////////////////////
/////////////////////////////////////////////////

class mage extends uvm_agent;
  `uvm_component_utils(mage)

  function new(string name = "mage", uvm_component parent = null);
    super.new(name, parent);
  endfunction 

  mmon                  m1;
  mdrv                  d1;
  uvm_sequencer #(mseq) seqr; // Standard sequencer

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m1   = mmon::type_id::create("m1", this);
    d1   = mdrv::type_id::create("d1", this);
    seqr = uvm_sequencer#(mseq)::type_id::create("seqr", this);
  endfunction 
 
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d1.seq_item_port.connect(seqr.seq_item_export); // Connected d1 to seqr
  endfunction 
endclass
   
 
////////////////////////////////////////////////////////////
////////////////////////   env   ///////////////////////////
///////////////////////////////////////////////////////////

class menv extends uvm_env ;
`uvm_component_utils (menv);

mage a1 ;
msco s1  ;

function new(string name = "menv",uvm_component parent = null );
super.new(name , parent );
endfunction 

  virtual function void build_phase (uvm_phase phase );
   super.build_phase (phase );
   a1 = mage::type_id::create("a1",this);
 s1 = msco::type_id::create("s1",this);
 endfunction 
 
virtual function void connect_phase (uvm_phase phase );
super.connect_phase (phase);
      a1.m1.port.connect(s1.imp);
   endfunction 
   
 
 
 endclass 
 
 ////////////////////////////////////////////////////////////
 ////////////////////  test  /////////////////////////////////
 //////////////////////////////////////////////////////////
 
 class mtest extends uvm_test ;
 `uvm_component_utils(mtest)
 
 menv e1 ;
 mseqr s1 ;
 
 function new(string name = "mtest", uvm_component parent = null );
 super.new(name , parent );
  endfunction 
  
  virtual function void build_phase (uvm_phase phase );
  super.build_phase (phase );
      e1 = menv::type_id::create("e1",this);
    s1 = mseqr::type_id::create("s1");
    endfunction 
    
  task run_phase(uvm_phase phase);
  phase.raise_objection (this);
  s1.start(e1.a1.seqr);
  phase.drop_objection (this);
  endtask 
  
  endclass 
  
  ///////////////////////////////////////////////////////////
  //////////////////  module /////////////////////////////
  ///////////////////////////////////////////////////
   
        

module testbench;
bit clk ;
always #5 clk = ~clk;
mux4to1_inf inf(clk);

mux4to1 uut (
   .rst(inf.rst),.clk(inf.clk),.sel(inf.sel),.in0(inf.in0),.in1(inf.in1),.in2(inf.in2),.in3(inf.in3),.out(inf.out));
initial begin 
  uvm_config_db#(virtual mux4to1_inf)::set(null , "*","vif",inf);
  run_test("mtest");
  end 
  
endmodule
