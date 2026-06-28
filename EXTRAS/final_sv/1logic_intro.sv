// Code your design here
module logic_intro;
  logic [7:0] data ;
  logic enable ;
  logic [7:0] double ;
  
  assign double = data << 1 ;
  
  initial begin 
    data = 8'b10110010;
    enable = 1 ;
    #10;
    $display ("enable = %b , data = %b ", enable , data );
    $monitor ("double = %b " , double );
  end 
endmodule 
