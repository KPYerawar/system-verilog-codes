module function_test;
int mul ;
function int calc_mul ( input int  a , input int b );
return a*b;
endfunction 

initial begin 
mul = calc_mul( 3 , 4 );
$display(" function out = %d " , mul );
end 
endmodule 
