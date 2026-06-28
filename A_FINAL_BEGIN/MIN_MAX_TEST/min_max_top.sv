`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2026 02:31:26 PM
// Design Name: 
// Module Name: min_max_top
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
WARMUP CHALLENGE: The Min/Max Finder (CODE31)

We are going to build a completely fresh, simple SystemVerilog environment.

The Hardware (DUT & Interface)

    Interface (CODE31_INTERFACE):

        a (8-bit logic)

        b (8-bit logic)

        max_val (8-bit logic)

        min_val (8-bit logic)

    DUT Logic: It is a simple combinational comparator.

        max_val gets the higher number between a and b.

        min_val gets the lower number between a and b.

        (If they are equal, both just get the value of a).

The Software Pipeline Requirements

    Packet (packet31): Randomize inputs a and b. Do not randomize outputs. Add a constraint so a and b are always inside the range of 10 to 50.

    Generator & Driver: Loop 15 times. Use a #10 delay.

    Monitor: Loop 15 times. Use your #9 and #1 trick to capture the inputs and outputs perfectly.

    Scoreboard: Loop 15 times. Predict what max_val and min_val should be using standard if/else logic, compare them to the physical results, and print [PASS] or [FAIL].

    Environment & Top: Wrap it all up cleanly just like you did in CODE30.

Take your time, map out the classes, and drop your full CODE31 code here when you are ready to see that wall of green [PASS] messages!
*/

class packet_minmax ;
rand bit [7:0] a ;
rand bit [7:0] b ;
logic  [7:0] max_val ;
logic  [7:0] min_val ;

constraint cons_min_max {
a inside {[10:56]} ;
b inside {[10:56]} ;
}

endclass 
/////////////////////// generator ////////////////////////////////
class gnerator_min_max ;
    packet_minmax p1 ;
    mailbox gen2drv ;
   function new( mailbox m );
             gen2drv = m ;
             endfunction 
        task run();
        repeat(15) begin 
               p1 = new();
               p1.randomize();
               gen2drv.put(p1);
               $display (" values are randmized and putted in the gen2drv mailbox at time = %t ", $time );
               #10;
               end                
            endtask 
   endclass 
   
   //////////////////////////////// driver //////////////////////////
   
   class driver_min_max ;
      packet_minmax p1 ;
      mailbox gen2drv ;
      virtual min_max_interface vif ;
          function new (virtual min_max_interface v  , mailbox m );
                vif = v ;
                gen2drv = m ;
                endfunction 
           task run() ;
           repeat (15) begin
              p1 = new();
              gen2drv.get (p1);
              vif.a = p1.a ;
              vif.b  = p1.b ;
              #10;
              end                  
      endtask 
      endclass
      /////////////////////////////  monitor ////////////////////////
               class monitor_min_max ;
                    mailbox mon2sco ;
                    packet_minmax p1 ;
                    virtual min_max_interface vif ;
                 function new( virtual min_max_interface v , mailbox m );
                     mon2sco = m ;
                     vif = v ;
                     endfunction 
                task run();
                   repeat (15) begin 
                   #9;
                      p1 = new();
                      p1.a = vif.a ;
                      p1.b = vif.b ;
                      p1.min_val = vif.min_val;
                      p1.max_val = vif.max_val;
                      $display ("[%0t] a = %d , b = %d , min_val = %d , max_val = %d " , $time , vif.a , vif.b , vif.min_val , vif.max_val );
                      mon2sco.put (p1);
                      #1;
                      end 
                      endtask 
                      endclass 
 //////////////////////////////// scoreboard /////////////////////////
                   class scoreboard_min_max ;
                         packet_minmax p1 ;  
                         mailbox mon2sco ;
                         function new(mailbox m );
                            mon2sco = m ;
                            endfunction 
                         task run();
                         logic [7:0] exp_max ;
                                 logic [7:0] exp_min ;
                          repeat (15) begin 
                               
                                 mon2sco.get(p1);
                       
        if (p1.a < p1.b ) begin 
             exp_max = p1.b ;
             exp_min = p1.a ;
            end 
        else if ( p1.a > p1.b ) begin 
           exp_max = p1.a ;
           exp_min = p1.b ;
           end 
        else begin 
           exp_max = p1.a ;
           exp_min = p1.a ;
            end
               
            if (exp_max == p1.max_val && exp_min == p1.min_val )
                $display ("[pass]");
              else 
                $display ("[fail]"); 
                end    
           endtask 
        endclass 
 //////////////////////////////////// environment ///////////////////
                         class environment_min_max ;
                                virtual min_max_interface vif ;
                                 function new(virtual min_max_interface v );
                                    vif = v ;
                                    endfunction 
                                gnerator_min_max g1 ;
                                driver_min_max d1 ;
                                monitor_min_max m1 ;
                                scoreboard_min_max  s1 ;
                                mailbox gen2drv ;
                                mailbox mon2sco ;
                                
                                
                                task run () ;
                                 gen2drv = new();
                                 mon2sco = new();
                                 g1 = new(gen2drv);
                                 d1 = new(vif , gen2drv);
                                 m1 = new(vif , mon2sco);
                                 s1 = new(mon2sco) ;
                                 fork 
                                  g1.run();
                                  d1.run();
                                  m1.run();
                                  s1.run();
                                  join 
                                  endtask 
                                  endclass 
                     
                     
                     
                                                                 
   
   module min_max_top;
   min_max_interface intf();
                     
                     Min_Max_Finder f1 (
                     .a(intf.a),.b(intf.b),.max_val(intf.max_val),.min_val(intf.min_val));
                     
                     environment_min_max e1 ;
                     initial begin 
                     e1 = new(intf);
                     e1.run();
                     end 
                     
                     
endmodule
