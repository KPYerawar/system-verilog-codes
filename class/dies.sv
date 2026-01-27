module dies ;
class dies1;
rand int dienum;
constraint die_nem{
value >= 0;
value <= 6;
}
endclass
dies1 d1 ;
initial begin 
d1 = new();
repeat (10) begin 
$display("current value on die = %d "  , d1.value);
end 
end 
endmodule
