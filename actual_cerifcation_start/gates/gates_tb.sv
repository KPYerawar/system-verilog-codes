module gates_tb;
logic [3:0] in1 , in2 ;
logic [3:0] and1 , or1 , xor1 , nand1 , nor1 , xnor1 ;

gates g1 (
.in1(in1),
.in2(in2 ),
.and1(and1),
.or1(or1),
.xor1(xor1),
.xnor1(xnor1),
.nor1(nor1),
.nand1(nand1));

initial begin 
in1 = 'h0;
in2 = '1;
#50 ;
$display("andgate value = %0b " , and1);
$display("in2 value = %0b " , in2);
end
endmodule
