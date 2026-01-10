module string_bit_byte;
string name = "krushna ";
bit [7:0] bit1 = "d";
bit [8*11 :0 ] hello = "hello world" ; //hello world is 11 letterd and each is 8 bit
byte letter = "d" ;

initial begin 
$display (" name = %s \n  bit1 = %s \n hello = %s \n letter = %s " , name ,   bit1 , hello , letter );
end 
endmodule 
