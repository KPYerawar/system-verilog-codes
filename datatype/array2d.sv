module array2d;
int array2 [0:7][0:3];
int array3 [8][4];
initial begin 
array2[7][3] = 1 ;
  $display(array2);
  $display(array3);
  end
endmodule 
