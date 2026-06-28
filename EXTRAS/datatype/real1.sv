module real1 ;
real pi = 3.14 ;
real pi_3decimal = 3.14;
real expo = 16e6;

initial begin 
$display ( " pi = %f \n pi_3decimal = %0.3f \n expo = %d \n expo = %b " , pi , pi_3decimal , expo , expo );
end 
endmodule 
