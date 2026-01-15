module sample_all_datatype;
bit bit_a ;   // store single bit 
bit [31 : 0 ] bit_32_a;  // store 32 bit due to vector size
int unsigned un_int_a ; // unsigned 32 bit integer 
int int_a ; // 32 bit signed value ;
byte byte_a ; // 8 bit veriable ;
shortint shortint_a ; //  16 bit integer 
longint longint_a ; // 64 bit integer
integer integer_a; // 1 , 0 , x ,z 32 bit integer ( 4 state)
time t ; //64 bit 4 state unsigned integer
real real_a ;// 2 state double precision floating veriable 



initial begin 
bit_a = 0 ;
$display(" bit_a store single bit  = %b "  , bit_a) ;
bit_32_a = 32'hab32;
$display(" bit_32_a store 32 bit due to vector size = %b"  , bit_32_a ) ;
un_int_a = 32'haaee;
$display(" un_int_a unsigned 32 bit integer =%b "  , un_int_a ) ;
int_a = -32;
$display(" 32 bit signed value = %b"  , int_a ) ;
byte_a = 'h0;
$display("  byte_a 8 bit veriable = %b; "  , byte_a ) ;
shortint_a = 16'habc;
$display(" shortint_a 16 bit integer = %b"  , shortint_a ) ;
longint_a = 227722;
$display("  longint_a  64 bit integer =%b"  , longint_a ) ;
integer_a = 001133;
$display("  integer_a 1 , 0 , x ,z 32 bit integer ( 4 state) =%b "  , integer_a ) ;
t = '1;
$display("  t 64 bit 4 state unsigned integer = %b "  , t ) ;
real_a = 4.5;
$display("  real_a  2 state double precision floating veriable  = %b "  , real_a ) ;
end
endmodule


 
