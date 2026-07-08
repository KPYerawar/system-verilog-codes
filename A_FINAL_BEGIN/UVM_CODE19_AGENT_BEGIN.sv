`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2026 10:05:34 PM
// Design Name: 
// Module Name: UVM_CODE19_AGENT_BEGIN
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
////////////////////   inteface //////////////////////////////////
interface my_if19 (input logic clk);
logic valid;
endinterface 

///////////////////// driver /////////////////////////////////////
class my_driver19 extends uvm_driver ;
   `uvm_component_utils(my_driver19)
 
 virtual my_if19 vif ;
 
    function new(string name = "my_driver19",uvm_component parent = null);
       super.new(name,parent);
       endfunction
       
       virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
                       if(uvm_config_db#(virtual my_if19)::set(this,"","vif",vif))begin
                           `uvm_fatal("UVM ERROR","DATABASE NOT FOUND");
                         end 
                       else `uvm_info("DATABASE FOUND","EVERYTHING IS FINE",UVM_LOW);
                   endfunction 
           task run_phase(uvm_phase);
             my_transaction19 tx ;
                
                `uvm_info("UVM DRIVER","I AM UPDATED ONE ",UVM_LOW );
                forever begin 
                  seq_item_port.get_next_item(tx);
                  
                    @(posedge vif.clk);begin 
                      vif.valid <= tx.valid ; end 
                  #50 ;
                      vif.valid <= 0 ;
           
                                    seq_item_port.item_done();

             end    endtask 
                 endclass 
////////////////////////////// sequence defination ////////////////////////
      class my_sequence19 extends uvm_sequence;
          `uvm_component_utils(my_sequence19)
           
            function new(string name = "my_sequence19");
               supre.new(name);
                           task body();
                                  my_transaction tx;
                                    repeat(3) begin 
                                         tx = my_transaction::type_id::create("tx");
                                         
////////////////////////////// sequencer defination ///////////////////////////
  typedef uvm_sequencer #(my_transaction19) my_sequencer19;
  
////////////////////////////// monitor /////////////////////////////////////////////       
           class my_monitor19 extends uvm_monitor ;
              `uvm_component_utils (my_monitor19)
                  
                   virtual function void build_phase(string name = "my_monitor19",uvm_component parent = null );
                    super.build_phase(phase);
                      if (!uvm_config_db#(virtual my_if19)::get(this , "","vif",vif))begin 
                        `uvm_fatal("ERROR","DATABASE NOT FOUND");
                        end 
                        else begin 
            `uvm_info("MON_BUILD", "UVM MONITOR FOUND VIF DATA", UVM_LOW);
        end
                    endfunction 
                    
                    task run_phase(uvm_phase phase );
                        forever begin 
                            @(posedge vif.clk);
                            if(vif.valid == 1 ) begin 
                               `uvm_info("valid state " , "valid = 1 " , UVM_LOW);
                               end 
                               end 
                               endtask 
                               endclass     
                  
                        
                          
    
    
    
module UVM_CODE19_AGENT_BEGIN(

    );
endmodule
