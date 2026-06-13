module practice ;


 logic [3:0] out1;
 logic [3:0] out2;
 logic [3:0] out3;
 logic [3:0] out4;
real pi ;
real expo ;
string myname = "krushna ";
bit [8*17:0] hello = "hello world";


//this code is for comment , real , logic , value width padding 
initial begin
out1 = 'h0;
out2 = 'hz;
out3 = 'hx;
out4 = 'h1;
pi  = 3.14 ;
expo = 4e3;

$display("out1 = %h " , out1);
$display("out2 = %b" , out2);
$display("out3 = %b " , out3);
$display("out4 = %b " , out4);
$display("pi  = %f " , pi);
$display("expo  = %0f " , expo);
$display("expo  = %0b " , expo);
$display("expo  = %0d " , expo);
$display ("hello my name is kpy \
ans todayi an practicing sv");
$display("my name = %s " , myname);
$display("my name = %s " , hello);
end
endmodule

