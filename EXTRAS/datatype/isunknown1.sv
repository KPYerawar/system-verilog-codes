module isunknown1;
logic a ;
int b ;
initial begin 
$display("4 state value detwcted on a = %b , b = %b  " , a  , b );
if($isunknown(a) == 1 )
$display("4 state value detwcted on a = %b " , a );
end endmodule
