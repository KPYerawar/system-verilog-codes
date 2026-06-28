interface int_and;
  logic A , B ;
  logic C;
endinterface 

class transaction ;
  rand bit a , b ;
  bit c ;
  constraint c1{
      a == 1 ;
    };
  function void display ();
    $display (" in1 = %b , in2 = %b , out1 = %b ", a , b , c );
    
    
  endfunction 
  
endclass 

transaction tr ;
module and_test;
  int_and intf() ;
  
  and1 a1 (
    .in1(intf.A),.in2(intf.B),.out1(intf.C));
  
  initial begin 
    tr = new ();
    
    repeat (10) begin 
      tr.randomize();
      intf.A = tr.a ;
      intf.B = tr.b;
      #10;
      tr.c = intf.C;
      tr.display ();
    end 
  end 
endmodule 

