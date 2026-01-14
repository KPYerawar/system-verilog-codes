module ref_practice;
int x = 10 ;
int y = 20 ;

function automatic void swap_value( ref int a , ref int b );
int temp = a ;
a = b ;
b = temp ;

x = a ;
y = b ;

endfunction 


initial begin 
$display("before swap x = %d , y = %d " , x , y );
 swap_value(x , y);
 $display("before swap x = %d , y = %d " , x , y );
 end 
 endmodule
