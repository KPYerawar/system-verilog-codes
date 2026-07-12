import uvm_pkg::*;
`include "uvm_macros.svh"

interface my_if22 (input logic clk);
logic data ;
endinterface 


class my_driver22 extends uvm_driver;
  `uvm_component_utils(my_driver22)
  
  function new(string name = "my_driver22",uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  virtual my_if22 vif ;
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual my_if22)::get(this , "","vif",vif))begin 
      `uvm_fatal ("ISSUE FOUND", "NO DATA FOUND ");
    end 
    else begin 
      `uvm_info ("DATA FOUND ", "DATA FOUND SUCCESSFULLY ",UVM_LOW);
    end
  endfunction 
     
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    @(posedge vif.clk);
      begin 
           vif.data <= 1 ;
      end 
    #3;
    vif.data <= 0 ;
    phase.drop_objection(this);
  endtask 
endclass 

  
class my_monitor22 extends uvm_monitor ;
  `uvm_component_utils (my_monitor22)
  
    virtual my_if22 vif ;
  function new(string name = "my_monitor22" , uvm_component parent = null);
    super.new(name, parent );
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual my_if22)::get(this,"","vif",vif))begin 
      `uvm_fatal("ERROR", "MONITOR DIDNT RECEIVER DATA ");
    end 
    else 
      `uvm_info("HELLP MONTOR "," " , UVM_LOW);
  endfunction 
  
  task run_phase (uvm_phase phase ) ;
    forever begin 
      @(posedge vif.data); 
      if(vif.data == 1 )
      `uvm_info("WE GOT IT ", "DATA == 1 ",UVM_LOW);
      end 
  endtask 
endclass 

class my_agent22 extends uvm_agent ;
  `uvm_component_utils(my_agent22)
  
  my_driver22 d1 ;
  my_monitor22 m1 ;
  
  function new(string name = "my_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     d1 = my_driver22::type_id::create("d1",null);
    m1 = my_monitor22::type_id::create("m1",null);
  endfunction  
endclass
  
    
module design22 ;
 my_agent22 a1;
  
  bit clk ;
  always #1 clk = ~clk ;
  my_if22 inf(clk);
  initial begin 
    `uvm_info ("HELLO", "ED PLAYGROUND",UVM_LOW);
    a1 = my_agent22::type_id::create("a1",null);
    uvm_config_db#(virtual my_if22)::set(null,"*","vif",inf);
    run_test();
  end
endmodule s
