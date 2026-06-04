`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2026 02:26:09 PM
// Design Name: 
// Module Name: CODE17_SPEED_RADAR
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
The Challenge: The Speed Radar System

You are designing a testbench for a police speed radar.

Hardware Specifications:

    The Data:

        You need a way to hold a random 8-bit speed value.

    The Radar (Generator):

        Needs to generate 5 separate speed readings.

        For every reading, it takes #10 time units to measure the speed.

        After the delay, it sends the speed data through a secure communication channel to the police laptop.

        It should print: [Time] Radar measured: X mph

    The Police Laptop (Receiver):

        Needs to connect to the exact same communication channel.

        It waits to receive data. Once it gets it, it takes #5 time units to process the data on the screen.

        The Logic: * If the speed is greater than 100, print: [Time] ALARM! Overspeeding at X mph!

            If the speed is exactly 0, print: [Time] Car is parked.

            For any other speed, print: [Time] Safe driving at X mph.

        It must do this for all 5 readings.

    The Top Environment:

        Build the channel.

        Build the Radar and the Laptop.

        Start them at the exact same time so they can communicate in parallel.
        */
        
        class packet;
         rand bit [7:0] speed ;
         endclass 
         
         class radar;
         mailbox mbx ;
         function new(mailbox m );
          mbx = m ;
         endfunction 
         
         task run ();
         packet p1 ;
         repeat(5) begin 
         p1 = new();
         p1.randomize();
         mbx.put(p1);
         $display(" time = %t , speed  = %d mph ", $time , p1.speed );
         #5;
         end endtask endclass
         
         class laptop ;
         packet p1 ;
         mailbox mbx ;
         function new(mailbox m );
          mbx = m ;
          endfunction 
          
          task run() ;
          repeat (5) begin 
          mbx.get(p1);
              if ( p1.speed >= 100 )
                $display (" overspeeding");
              else begin 
                $display (" not overspeeding ");end 
              #5;
           end 
           endtask 
           endclass
            
          
          
         
module CODE17_SPEED_RADAR;
mailbox mbx ;
radar r1;
laptop l1 ;
initial begin 
mbx = new();
r1 = new(mbx);
l1 = new(mbx);
fork 
   r1.run();
   l1.run();
   join 
   $display ("speed check completed ");
   end 
endmodule
