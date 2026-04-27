module logic_intro;
logic [7:0]number ;
logic onebit;

logic [8:0]double;
initial begin 
number = 8'b10101010;
#20;
$display("double - %d , onebit = %d ",  double , onebit );
end 
double = number << 1 ;
onebit = 1 ;
endmodule  
