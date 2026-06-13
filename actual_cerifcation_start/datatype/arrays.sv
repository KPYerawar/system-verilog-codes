module arrays;
int lowtohigh [ 3:0];
int array [3] ;
int i ;
initial begin 
lowtohigh = '{ 0 , 1 , 2 ,3};
foreach(lowtohigh[i]) begin 
$display("lowtohigh = %d", lowtohigh[i]);
end
array = '{1 ,2 , 3 };
for ( i = 2 ; i >=0 ; i = i -1) begin 
$display("array using for loop is = %d " ,array[i]);
end
end 
endmodule
