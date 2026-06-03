`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2026 08:47:29 AM
// Design Name: 
// Module Name: CODE14_GENERATOR
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

class scorecard; // generate the variable hold random nvalyes 
rand bit [7:0] score;
endclass 

class generator ;// the whole generatoe 
mailbox mx; // mailbox is just for using object not instianted here right now 

function new(mailbox m );
mx = m ; // mailbox fromthe module comehere and put in mbx of class mailbox 
// now thie class have mailbox mbx have sone data 
endfunction

task run();
scorecard sc; //randomizer is called rand varible filling 
repeat (3) begin 
sc = new(); // sc is instanited 
sc.randomize();
mx.put(sc); // random values puted inside mailbox 
$display (" current paket = %d . " , sc.score);
end 
endtask 
endclass 



module CODE14_GENERATOR;
generator gen ; // now we have only contero ovr generator class 
mailbox mbx;
initial begin 
mbx = new();
gen = new(mbx); // as we disscussed earlier the generator will receive the mbx but not space to hold it this we create tht mailbox mbx again in generator lass 

gen.run ();
$display("Total items in mailbox: %0d", mbx.num());// builtin function counte swhenever the number valrible changes 
end 
endmodule
