module void_practice;

function void check_error(input int error_code);
if ( error_code == 404)
$display("no page found ");
else if (error_code == 500)
$display("server crash ");
else 
 $display("unknown code ");
 
 endfunction
 
 initial begin 
 check_error(200);
 #20;
 check_error(404);
 #20;
 check_error(500);
 #20 ;
 end 
 endmodule 

