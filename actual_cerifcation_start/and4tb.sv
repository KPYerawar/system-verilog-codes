  class transaction ;
    rand bit [3:0 ] data_in ;
    bit out ;
    
    
    function void display ( ) ;
      $display ( " inputs = %d , output = %d " , data_in , out );
    endfunction 
  endclass
  



module and4tb_sv ;
  logic [3:0] dut_in ;
  logic dut_out ;
  
  and4 dut (.data_in(dut_in), .out(dut_out));
  
  transaction tr ;
  
  initial begin 
    tr = new ();
    
    repeat (10 ) begin 
      tr.randomize();
      
      dut_in = tr.data_in ;
      #10;
      tr.out = dut_out ;
      tr.display ();
    end 
  end
  
  
    
endmodule 
