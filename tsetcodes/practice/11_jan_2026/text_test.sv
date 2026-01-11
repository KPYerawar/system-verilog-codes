module text_test ;
bit [4*8:0] v = "VLSI";
string s = "is cool";
initial begin 
$display (" full sen = %s %s & hex value = %h%h " , v , s , v , s);
end endmodule
