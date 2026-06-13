module traffic_light;
class trafficlight;
rand int colour_code;


constraint codes{
colour_code >= 0 ;
colour_code  <= 2;
}
endclass 

trafficlight t1;

initial begin 
t1 = new();

repeat(10) begin 
void'(t1.randomize());
$display(" clour is = %d " , t1.colour_code);
end end endmodule 
