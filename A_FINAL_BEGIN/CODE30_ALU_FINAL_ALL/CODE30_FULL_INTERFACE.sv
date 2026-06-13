`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2026 08:49:02 AM
// Design Name: 
// Module Name: CODE30_FULL_INTERFACE
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

class packet30 ;
rand  bit enable ;
rand bit [1:0] opcode; 
rand bit  [7:0] a ;
rand bit  [7:0] b ;
logic [7:0] result; 

constraint cons1 {
enable dist {
0 := 10 ,
1 := 90 };
}

endclass 

class generator30 ;
packet30 p1 ;
mailbox gen2drv ;

function new(mailbox m ) ;
  gen2drv = m ;
  endfunction 
  
  
task run() ;
    repeat (20)  begin 
    p1 = new() ;
    p1.randomize();
    gen2drv.put(p1);
    $display (" randomized at %t " , $time );
    #10 ;
    end 
    endtask 
    endclass 
    
    
    class driver30 ;
    packet30 p1 ;
    mailbox gen2drv ;
    virtual CODE30_INTERFACE vif ;
    
    function new(virtual CODE30_INTERFACE v , mailbox m );
    gen2drv = m ;
    vif = v ;
    endfunction 
    
    task run();
    repeat (20) begin 
    p1 = new();
    gen2drv.get(p1);
    vif.a = p1.a ;
    vif.b = p1.b ;
    vif.enable = p1.enable ;
    vif.opcode = p1.opcode ;
    #10;
    end 
    endtask endclass 
    
    class monitor30;
    mailbox mon2sco;
    packet30 p1 ;
    virtual CODE30_INTERFACE vif ;
    
    function new(virtual CODE30_INTERFACE v , mailbox m );
    mon2sco = m ;
    vif = v ;
    endfunction 
    
    task run() ;
    repeat (20) begin 
    #9 ;
    mon2sco.get(p1);
    p1 = new();
        p1.a = vif.a ;
    p1.b = vif.b ;
    p1.opcode = vif.opcode ;
    p1.result  = vif.result ;
    p1.enable = vif.enable;
    $display ("[%0t] at score a = %d , b = %d ,enable = %d , opcode = %d , result = %d ", $time, vif.a , vif.b , vif.enable, vif.opcode , vif.result );
    mon2sco.put(p1);
    #1;
    end 
    endtask 
    endclass 
    
    
    class scoreboard30 ;
packet30 p1 ;
mailbox mon2sco;
function new(mailbox m );
mon2sco = m ;
endfunction 

task run();
logic [7:0] expected_result;

repeat (20) begin 

     if (p1.enable == 0 ) 
 expected_result = 0 ;
 else begin 
 case (p1.opcode )
    2'b00 : expected_result = p1.a + p1.b ;
    2'b01 : expected_result = p1.a - p1.b ;
    2'b10 : expected_result = p1.a & p1.b ;
    2'b11 : expected_result = p1.a | p1.b ;
    endcase 
  end  
    
    if (expected_result == p1.result )
       $display("[pass]");
       else 
         $display ("[fail]");
    end 
    endtask 
    endclass 
     
class env30 ;
virtual CODE30_INTERFACE vif;
function new(virtual CODE30_INTERFACE v);
  vif = v;
endfunction
generator30 g1 ;
driver30 d1 ;
scoreboard30 s1 ;
monitor30 m1 ;
mailbox gen2drv ;
mailbox mon2sco ;



task run();
gen2drv = new();
mon2sco = new();
g1 = new(gen2drv);
d1 = new( vif , gen2drv);
m1 = new( vif , mon2sco);
s1 = new(mon2sco );
fork 
g1.run ();
d1.run();
s1.run();
m1.run();
join 
endtask 
endclass 

module CODE30_FULL_INTERFACE;
CODE30_INTERFACE intf();
CODE30_ALU a1 (
.a(intf.a),.b(intf.b),.opcode(intf.opcode),.result(intf.result),.enable(intf.enable));
environment30 e1 ;
initial begin 
e1 = new(intf);
end 
endmodule
