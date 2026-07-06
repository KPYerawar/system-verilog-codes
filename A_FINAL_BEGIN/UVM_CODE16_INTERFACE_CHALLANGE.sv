`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 09:45:19 PM
// Design Name: 
// Module Name: UVM_CODE16_INTERFACE_CHALLANGE
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

/*Your task is to test a simple Address Bus Interface by writing a complete UVM-based SystemVerilog code from scratch.
Challenge Specifications & Rules:

1. The Interface Block

    Interface Name: addr_if

    Inside it, declare exactly three signals:

        clk (passed as an input logic)

        logic [3:0] addr

        logic addr_valid

2. The Driver Class

    Driver Name: addr_driver (must extend uvm_driver).

    Remember to register it using the factory macro (without a semicolon!).

    Add the standard family-tree constructor (name and parent).

    Declare your local virtual interface handle inside the class.

    Inside build_phase: Retrieve (get) the interface pointer from the uvm_config_db using the lookup tracking string key "vif". Handle the error with uvm_fatal if it fails to find it.

    Inside run_phase:

        First, print an info message: "Waiting for clock..."

        On the very first clock edge (@(posedge vif.clk);), drive the hardware pins: set vif.addr to 4'hF and vif.addr_valid to 1'b1.

        Introduce a time delay of #20; ns.

        Right after the delay, clear the validation signal by setting vif.addr_valid back to 1'b0.

        Print a final info message: "Address successfully driven!"

        Don't forget to wrap the simulation logic cleanly between your objection controls (raise and drop).

3. The Hardware Top Module

    Module Name: top_module

    Generate the live clock signal using an always #5 clk = ~clk; loop.

    Instantiate the physical interface instance and pass the running clock into it.

    Inside the initial block:

        Create the driver object using the UVM Factory structure (::type_id::create("d1", null)).

        Deposit (set) the live physical interface into the uvm_config_db so the driver can fetch it.

        Kickstart the entire background automated phase ecosystem by calling run_test();.
        */
        
        
                               
import uvm_pkg::*;
`include "uvm_macros.svh"


      interface addr_if (input logic clk);
       logic [3:0] addr ;
       logic addr_valid ;
       endinterface 
       
       class addr_driver extends uvm_driver ;
       `uvm_component_utils (addr_driver)
       
       function new(string name = "addr_driver" , uvm_component parent = null);
       super.new(name, parent);
       endfunction 
       
       virtual addr_if vif ;
       
       virtual function void build_phase(uvm_phase phase );
               super.build_phase(phase);
                   if (!uvm_config_db#(virtual addr_if)::get(this , "" , "vif" , vif )) begin 
                            `uvm_fatal("ERROR!!","DATABASE NOT FOUND ");  end 
                       else begin 
                               `uvm_info("EVERYTHING FINE " , "DATABASE FOUND -- WAITING COR CLOCK " , UVM_LOW);
                               end 
                               endfunction 
             task run_phase(uvm_phase phase);
                     phase.raise_objection(this);
                              `uvm_info("TASK MESSAGE","WE ARE INSIDE TASK",UVM_LOW);
                          
                          @(posedge vif.clk)begin 
                               vif.addr <= 4'hf;
                               vif.addr_valid <= 1'b1 ;
                               #20;
                               vif.addr_valid <= 0 ;
                                end 
                             
                          `uvm_info("GOT THE CLK","DESIGN IS WORKING",UVM_LOW);
                          phase.drop_objection(this);
                     endtask 
                     endclass 
                     
                     
       



module UVM_CODE16_INTERFACE_CHALLANGE;
bit clk ;
addr_driver d1 ;
always #5 clk = ~clk;
addr_if inf(clk);
        initial begin 
            `uvm_info("UVM HAS STARTED STSE 1 " , "LETS BEGIN " , UVM_LOW);
                 d1 = addr_driver::type_id::create("d1", null);
             `uvm_info("UVM HAS STARTED STSE 2 " , "OBJECT CREATED " , UVM_LOW);
               uvm_config_db#(virtual addr_if)::set(null , "*", "vif",inf);
                           `uvm_info("UVM HAS STARTED STSE 3" , "INF LOADED " , UVM_LOW);
                           run_test();
                           end 


endmodule
