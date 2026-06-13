module comparator ;
logic [1:0] a ;
logic [1:0] b ;
logic is_equal;
initial begin 
a = 2'b00;
b = 2'b10;
end
always_comb begin 
if ( a == b ) 
is_equal = 1'b1 ;
else 
is_equal = 1'b0;
end 
initial begin 
#10;
$display (" is equal = %b , when a = %b , and b = %b", is_equal , a , b );
end
endmodule 
