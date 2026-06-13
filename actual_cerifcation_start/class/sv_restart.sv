module sv_restart ;// still w ewill satrt from dies code 
class die_num;
rand int numvalue;
constraint dienum{
numvalue <= 6 ;
numvalue >= 0 ;
}
endclass

die_num d1;
initial begin 
d1 = new();
repeat(10) begin 
    d1.randomize();

  $display ("num o die is = %d " , d1.numvalue );
#10;
end 
end
endmodule 
