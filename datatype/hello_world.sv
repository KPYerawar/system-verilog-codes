module hello_world;
initial begin 
$display("hello world" );  // display the statement once the simulation and automatically hits enter 
$write("hello world "); // same task as display but it dosent include any enter , it prints the statement in same line 
$display (" line breaking statments \
to continue writing in nwe line");
$monitor (" hello world"); //monitor the chnge throughout the siulation
end 
endmodule  
