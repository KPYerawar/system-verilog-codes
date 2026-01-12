module always_comb1;
logic a ;
logic b ;
logic c ;
logic sel ;

initial begin 
a =1 ;
 b = 0 ;
 sel = 0 ;
 end 
  always_comb begin 
 if ( sel == 1) begin 
   $display (" 1st if block a = %d" , a ); end 
   else begin 
   $display (" else block b = %d " , b); end;
 end  
   endmodule   
