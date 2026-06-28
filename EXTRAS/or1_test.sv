interface or_int ;
  logic A , B ;
  logic OUT ;
endinterface 

class transaction ;
  rand bit a , b ;
  bit o ;
  
  
  function void display ();
    $display (" in1 = %b , in2 = %b " , a , b );
  endfunction 
endclass 

transaction tr ;
module or1_test;
  or_int intf();
  
  
  or1 o1 (
    .in2(intf.A),.in1(intf.B),.out1(intf.OUT ) );
  initial begin 
          tr = new();

    repeat (10 ) begin 
          tr.randomize ();

      intf.A = tr.a;
      intf.B = tr.b ;
      #10 ;
      tr.o = intf.OUT;
      tr.display();
    end 
  end 
endmodule 
  
