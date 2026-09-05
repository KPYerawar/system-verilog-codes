`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2026 10:14:34 AM
// Design Name: 
// Module Name: TESTBENCH_FIFO
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
module FIFO_RTL #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 8,
    parameter ADDR_WIDTH = 3
)(
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   w_en,
    input  logic                   r_en,
    input  logic [DATA_WIDTH-1:0]  data_in,
    output logic [DATA_WIDTH-1:0]  data_out,
    output logic                   full,
    output logic                   empty
);
    
  logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];
  logic [ADDR_WIDTH-1:0] wr_ptr;
  logic [ADDR_WIDTH-1:0] rd_ptr;
  logic [ADDR_WIDTH:0]   fifo_cnt; 

  
  assign empty = (fifo_cnt == 0);
  assign full  = (fifo_cnt == DEPTH);

  
  always_ff @(posedge clk) begin
    if (rst) begin
      wr_ptr <= '0;
    end else if (w_en && !full) begin
      mem[wr_ptr] <= data_in;
      wr_ptr      <= wr_ptr + 1'b1;
    end
  end

  
  always_ff @(posedge clk) begin
    if (rst) begin
      rd_ptr   <= '0;
      data_out <= '0;
    end else if (r_en && !empty) begin
      data_out <= mem[rd_ptr];
      rd_ptr   <= rd_ptr + 1'b1;
    end
  end

  
  always_ff @(posedge clk) begin
    if (rst) begin
      fifo_cnt <= '0;
    end else begin
      case ({w_en && !full, r_en && !empty})
        2'b10:   fifo_cnt <= fifo_cnt + 1'b1; 
        2'b01:   fifo_cnt <= fifo_cnt - 1'b1; 
        default: fifo_cnt <= fifo_cnt;        
      endcase
    end
  end

endmodule
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

interface fifo (input logic clk);
  logic                   rst;
 logic                   w_en;
  logic                   r_en;
  logic   data_in;
 logic   data_out;
 logic                   full;
 logic                   empty;
 endinterface 
 
 ///////////////////////////////////////////////////
 /////////////  sequence  //////////////////////////
 ////////////////////////////////////////////////
 
 class fseq extends uvm_sequence_item ;
 `uvm_object_utils(fseq)
 
 function new(string name = "fseq");
 super.new(name);
 endfunction 
 
 rand bit rst;
 rand bit w_en;
 rand bit r_en;
 rand bit [7:0] data_in;
 logic  [7:0] data_out;
 logic full;
 logic empty;
 
 endclass 
 
 ///////////////////////////////////////////
 ///////////// sequencer  /////////////////
 /////////////////////////////////////////
 
 class fseqr extends uvm_sequence #(fseq);
 `uvm_object_utils(fseqr)
 
 fseq s1 ;
 function new(string name = "feqr");
 super.new(name);
 endfunction 
 
 task body ();
 s1 = fseq::type_id::create("s1");
 repeat(5) begin 
      start_item(s1);
      assert (s1.randmize());
      finish_item(s1);
  end 
  endtask 
  endclass 
  
  ////////////////////////////////////////////////
  ///////////////////   driver  //////////////////
  ////////////////////////////////////////////////
  
  class fdrv extends uvm_driver #(fseq);
  `uvm_component_utils(fdrv)
  
  function new(string name = "fdrv", uvm_component parent = null ) ;
  super.new(name, parent);
  endfunction 
  
  virtual fifo vif ;
  
  virtual function void build_phase (uvm_phase phase ) ;
  super.build_phase (phase ) ;
       if ( !uvm_config_db#(virtual fifo)::get(this , "", "vif", vif))begin 
          `uvm_fatal ( "FATALA ERROR " , "DATA NOT FORUND ");
         end 
     else uvm_info ( "DRIVER " , "DATA FOUND AT DRIVER ", UVM_INFO ) ;
  endfunction 
 
 task run_phase (uvm_phase phase ) ;
      forever begin 
        seq_item_port.get_next_item(req);
          @(posedge vif.clk)
             vif.w_en <= req.w_en;
             vif.r_en <= req.r_en ;
             vif.data_in <= req.data_in ;
             vif.rst <= req.rst ;
         seq_item_port.item_done ();
      end 
   endtask 
   
//////////////////////////////////////////////////////////
/////////////////   monitor  ////////////////////////////
//////////////////////////////////////////////////////////

class fmon extends uvm_monitor ;
`uvm_component_utils ( fmon ) 

function new( string name = "fmon");
super.new(name ) ;
endfunction 

virtual fifo vif ;
uvm_analysis_port #(fseq) sq1 ;
fseq sq2 ;

virtual function void build_phase  (uvm_phase phase ) ;
super.build_phase (phase ) ;
     fsq1 =  new("fsq1");
       if ( !uvm_config_db#(virtual fifo)::get(this , "", "vif", vif))begin 
          `uvm_fatal ( "FATALA ERROR " , "DATA NOT FORUND ");
         end 
     else uvm_info ( "MONITOR " , "DATA FOUND AT MONITOR ", UVM_INFO ) ;
  endfunction 
        
 task run_phase ( uvm_phase phase );
    forever begin
      sq2 = fseq::type_id::create("sq2"); 
      #1;
        @(posedge vif.clk ) ;
           sq2.rst = vif.rst ;
           seq2.e_en = vif.w_en;
           seq2.r_en = vif.r_en ;
           seq2.data_in = vif.data_in ;
           seq2.empty = vif.empty ;
           seq2.full = vif.full;
           seq2.data_out = vif.data_out ;
        sq1.write (sq2);
      end 
    endtask 
   endclass 
   
 ///////////////////////////////////////////////////////////////////
 /////////////////////   scoreboard  ///////////////////////////////
 /////////////////////////////////////////////////////////////////
 
 class fsco extends uvm_scoreboard ;
 `uvm_component_utils(fsco)
 
 virtual fifo vif ;
 uvm_analysis_imp #(fseq,fsco) imp;
 bit [7:0] data_out ;
 bit empty ;
 bit full ;
 
 
 function new(string name = "fsco",uvm_component parent = null );
 super.new(name , parent );
 endfunction 
 
 virtual function void build_phase (uvm_phase phase )  ;
 super.build_phase (phase) ;
    imp = new("imp");
  endfunction 
  
  virtual function void write ( fseq s1 ) ;
  
     endfunction 
  endclass 
  
  
 /////////////////////////////////////////////////////////////////
 ///////////////////////////  agent  //////////////////////////////
 //////////////////////////////////////////////////////////////////
 
 class fage extends uvm_agent ;
 `uvm_component_utils (fage)
 
 function new(string name = "fage",uvm_component parent = null);
 super.new(name , parent );
 endfunction 
 
 fmon m1 ;
 fdrv d1 ;
 uvm_sequencer #(fseq) sq1 ;
 
      
                 
 
module TESTBENCH_FIFO(

    );
endmodule
