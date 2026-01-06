module gates(
input logic [3:0] in1,
input logic [3:0] in2,
output logic [3:0] and1,
output logic [3:0] or1,
output logic [3:0] xor1 ,
output logic [3:0] nor1,
output logic [3:0] nand1,
output logic [3:0] xnor1
);

assign and1 = in1 & in2 ;
assign or1 = in1 | in2 ;
assign xor1 = in1 ^ in2 ;
assign nand1 = ~( and1);
assign xnor1 = ~( xor1);
assign nor1 = ~( or1);

endmodule
