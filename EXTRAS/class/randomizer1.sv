module practice;
  class dice ;
    rand int value ;
    
    constraint  c_six_sides{
      value >= 1 ;
      value <= 6 ;
    }
    
  endclass 
  
  dice d1;
  
  initial begin 
    d1 = new();
    
    repeat (5) begin 
      void'(d1.randomize());
      $display("rolled die = %d " , d1.value);
    end 
  end 
endmodule 
