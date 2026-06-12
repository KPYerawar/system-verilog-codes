`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2026 07:30:28 AM
// Design Name: 
// Module Name: CODE28_MONITOR
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
class monitor ;
virtual my_intf vif;
mailbox mon2scb ; //mailbox for monitor and scoreboard 

function new(virtual my_intf v , mailbox m );
vif = v ;
m = mon2scb;
endfunction 

task run ();
packet p1;

repeat (20) begin 
p1 = new();
#20;
p1.data_in = vif.data_in ;
p1.data_out = vif.data_out ;

mon2scb.put(p1);
$display("[%0t] MONITOR: Captured in=%0d, out=%0d", $time, p_obs.in_data, p_obs.out_data);
    end
  endtask
endclass

module CODE28_MONITOR(

    );
endmodule
