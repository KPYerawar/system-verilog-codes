module parameter1;
parameter int memsize = 1024 ;
parameter int newwidth = $clog2 (memsize);

// how to use it ?
logic [memsize-1:0] memsize1;
logic [newwidth-1:0 ] newwidth1;
initial begin 
$display("mamsize = %d , newsize = %d" , memsize , newwidth );
end endmodule
