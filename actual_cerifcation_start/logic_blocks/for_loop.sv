module for_loop;
int i  = 0 ;
int array[5] = '{1 ,2 ,3 , 4 , 5};
initial begin 
// simple for loop ;
for (i = 0 ; i <= 10 ; i  = i +1) begin 
 $display(" hello world");
 #5;
 end  
 // using repeat 
 repeat (10) begin 
 $display (" helo world ");
 end
 // using foreach 
 foreach (array[i] ) begin 
 $display (" the numbers with ith position i = %b , num = %b ", i , array[i]);
 end 
 for (i = 0 ; i <= 10 ; i  = i +1) begin 
 $write(" hello world");
 #5;
 end  
 
 end endmodule
