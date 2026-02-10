
interface hf_if ;
  logic a , b ;
  logic sum , carry ;
endinterface 


class transaction ;
  rand bit in1 , in2  ;
  bit s , c ;
  
  
  constraint c_cons { 
    in1  == 1 ;
  }
    
    function void print1;
      $display(" a = %b , b = %b , sum = %b , carry = %b " , in1 , in2 , s , c );
    endfunction 
    endclass 
    
    transaction tr ;
    module tb_halfadder ;
      hf_if intf();
      
      half_adder h1 (
        .a(intf.a),.b(intf.b),.sum(intf.sum),.carry(intf.carry));
      
      initial begin 
        tr = new();
        
        repeat (10) begin 
          tr.randomize();
          
           intf.a = tr.in1 ;
          intf.b = tr.in2;
          #10;
          tr.s = intf.sum;
          tr.c = intf.carry;
          tr.print1();
        end 
      end 
    endmodule 
          
          
//////////////////////////////////////////////////

module half_adder (
  input  logic a, b,
  output logic sum, carry
);
  assign sum   = a ^ b; // XOR
  assign carry = a & b; // AND
endmodule
