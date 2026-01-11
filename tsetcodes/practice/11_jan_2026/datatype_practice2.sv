module datatype_practice2;
real pi ;
real radius ;
real area ;
initial begin
 pi = 3.14;
 radius = 4.5 ;
 area = pi * radius * radius ; 
$display ("area 2 decimal = %0.2f & int_area = %d " , area , area );
end endmodule 
