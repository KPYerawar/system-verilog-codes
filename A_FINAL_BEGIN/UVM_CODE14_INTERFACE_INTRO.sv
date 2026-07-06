`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 11:36:33 AM
// Design Name: 
// Module Name: UVM_CODE14_INTERFACE_INTRO
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
// this is the uvm all librery import code line 
`include "uvm_macros.svh"
// this line used to use the shortcut keys in uvm code 

/*
 we will the interface 1st here 
 ///////////////////////////////////////////////*/
 
 interface my_if14(input logic clk );
 //this is the interface code line for the data and variables and input as clock for the code 
 logic [7:0] data ;
 endinterface 
 
 //////////////////////////////////////////             
 //           driver                     //
 /////////////////////////////////////////
 class my_driver14 extends uvm_driver ;
 // this is our class which is extending like using the function inside the uvm driver 
 `uvm_component_utils (my_driver14)
//this lien telling the  uvm that do save this in uvm factory regiter 
 virtual my_if14 vif;
 // we are mporting the virtual variable as vif 
 function new(string name = "my_driver14" , uvm_component parent = null );
 //this is cunstructor function when we create the object it autoamtically runs 
 //and pass the our class name and parent as null because the there is not other module that contain the driver 
 // here driver is ont in env so no parent here so parent null 
 super.new(name , parent ) ;
//this super is below constructor so this helps the vm background for unning the uvm driver and make their own cunstructor work 
//then only other command s beow (our custom code below it ) will run 
 endfunction 
 
 virtual function  void build_phase(uvm_phase phase );
 // this function used for the teak running the phase is witen here 
 super.build_phase(phase);
 // stll confused with super 
 
    if (!uvm_config_db#(virtual my_if14)::get(this , "","vif", vif ))begin
     //||<----------------------------->|
     //this line tells the packet is having a virtual interface 
                                      //|<------------------------->||
                                    // vif act as tracking f for the data 
                                    // and tells the "vif" packet contasin variabe put it in the vif (my local packet ) put in my local packet variable 
                    `uvm_fatal("NO_VIF", "DRIVER DIDNT FOUND THE DAABASE ");
                   //fatal used to instantlly shutdown the siulation at that instant if condition satisfied 
                                     end 
                  endfunction 
 
 task run_phase (uvm_phase phase);
 // this is run phase for taks 
     phase.raise_objection(this);
//thsi raise tells the uvm that dont shutdown the simulation i am rnning my tasks plz wait 
             `uvm_info("INTERFACE IS IN CHECKING " , "RUNNING THE TASK ", UVM_LOW);
             // simple printing statemant 
             @(posedge vif.clk);
             vif.data <= 8'hf;
     #50;
     // the logic of the code design 
              `uvm_info("THE CLK IS GIVEN " , " AND THE DATA VALUE IS ASSIGNED ", UVM_LOW );
           phase.drop_objection(this);
//this tells that my simulation of task is doe you can taske control and shutdiwn the simulation 
           endtask 
           endclass 
        
module UVM_CODE14_INTERFACE_INTRO;
my_driver14 d1;
bit clk ;
    always #5 clk = ~clk;
    my_if14 inf(clk);
//this is instatition calling statement and passing clk 
    initial begin 
    d1  = my_driver14::type_id::create("d1",null);
    // object instantiation 
    
    uvm_config_db#(virtual my_if14)::set(null , "*" , "vif" , inf);
    // thisislike a post box the "vif" in envloupe and the inf is that data 
    run_test();
    // automaticaly calling the task for the object 
    end 
    
endmodule
