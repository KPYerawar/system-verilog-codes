module datatype_practice ;
logic [7:0] full_byte = 'hA5;
logic [3:0] upper_nibble;
logic [3:0] lower_nibble ;
logic [7:0] swaped;
initial begin
 upper_nibble = full_byte[7:4];
 lower_nibble = full_byte[3:0];
swaped = {lower_nibble , upper_nibble};
$display ("lower = %0b & upper = %0b & swaped = %h" , lower_nibble , upper_nibble , swaped);
end endmodule
