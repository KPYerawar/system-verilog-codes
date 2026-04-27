// Code your testbench here
// or browse Examples
module array_intro ;
  
  //fixed arry:-
  bit [7:0] fixed [3];
  //dynamic arry
  logic dynamic [];
  int i;
  initial begin 
    foreach (fixed[i])
      $display ("fixed[%d] = %d ", i,fixed[i]);
    #20;
    foreach (dynamic[i])
      $display ("dynamic[%d] = %d ", i,dynamic[i]);
    #20;
    //fill the fixed array and printe size 
    foreach (fixed[i])
      fixed[i] = 20;
    #20;
    foreach (fixed[i])
      $display ("fixed[%d] = %d , ", i,fixed[i]);
    #20;
    $display("Size: %0d", dynamic.size());  // Object-oriented style (Clean)
    $display("Size: %0d", $size(dynamic));  end 
endmodule 
