module case_block;
logic sel ;
logic a ;
logic b ;

always_comb begin 
case(sel) 
 1'b1: begin a= 1; 
    b = 1 ;end
    1'b0: begin a= 0; 
    b = 0 ;end
// default : begin a = 1 ; b = 0 ; end
 endcase 
 end 
initial begin 
$monitor (" the table sel = %b , a = %b , b = %b " , sel , a , b );
#10;
sel = 1 ;
#10 ;
sel = 0 ;
end 


 endmodule 
