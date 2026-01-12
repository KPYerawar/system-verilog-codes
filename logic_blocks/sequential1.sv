module sequential1;
logic clk ;
logic q ;
logic d ;

initial clk = 0 ;
always #5 clk = ~clk ;
always_ff @( posedge clk ) begin 
q <= d;
end 

initial begin 
$monitor ("d = %b", q );
d = 1 ;
#10;
d = 0 ;
#10;

$finish;
end 
endmodule 
