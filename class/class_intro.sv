module class_intro ;
class packet;
bit [7:0] header;
bit [7:0] payload;
bit crc;

function void print();
$display("header = %b , payload = %b " , header , payload );
endfunction 
endclass 

packet p1;

initial begin 
p1 = new() ;
p1.header = 8'b1100;
p1.payload = 8'b110011;
p1.print();
end 
endmodul
