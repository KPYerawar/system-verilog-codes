module padding_variable;
logic [3:0] ones = 'h1;//this will fill only lsb bit by 1 and rest by 0
logic [3:0] ones1111 = '1; // this will fill all bits by 1
logic [3:0] impedence = 'hz; //out = zzzz
logic [3:0] unknown = 'hx ;
logic [3:0] zeros = 'h0 ;

initial begin 
$display ("ones = %b \n onlyone = %b \n impedencd = %b \n unknown = %b \n zeros = %b " , ones , ones1111 , impedence , unknown , zeros);
end 
endmodule
