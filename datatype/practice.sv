module practice;
int low_to_high [3:0] = '{11,22,33,44};
int array[3][2];
int i ;
initial begin 
for (i = 0 ; i < 4 ; i = i + 1) begin 
$display(" we are startin printine things low_to high = %d , array =  " , low_to_high[i] );
end 
$display(array);

end
endmodule 
