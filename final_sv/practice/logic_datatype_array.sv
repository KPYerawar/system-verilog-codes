module week_revision1;
  
  // begin for logic 
  logic [3:0] number ;
  logic [4:0] double ;
  
  // datatypes 
  bit a ; // one bit storage 
  byte b; // 8 bit storage 
  bit [3:0] c ; // 4 bit storage 
  shortint d ; // 16 bit storage 
  int e ; // 32 bit default storage
  longint f ; // 64 bit storage 
  
  // begin for arrays 
  // fixed array 
  logic  [3:0]arr1 [3];
  // this is 3x4 array matrix 
  // dynsmic array 
  logic [20:0] arr2 [];
  int i ;
  
  
  
  initial begin 
    $display("-- today we will practice the logic , datatype , array , queue , associative arrays ----");
    $display ("--------logic demo----------");
    number = 4'd15;
    double = number << 1 ;
    $display (" number = %d , double = %d", number , double );
    $display (" logic demo end ");
    $display("begin for datatypes");
    a = 1;
    b = 8'd32;
    c = 4'd12;
    d = 16'h03b;
    e = 32'd44;
    f = 64'h0xabc;
    $display("a = %b  b = %b , c= %b , d = %b , e = %b , f = %h", a, b , c , d , e, f );
    $display("----------datatype demo end ----------");
    $display("lets begin for array");
    arr1[0] = 10;
    arr1[1] = 12;
    arr1[2] = 15;
    
    foreach(arr1[i])
      $display("arr i = %d  == %d ", i , arr1[i]);
    $display("size of array = %d ", $size(arr1));
    
    $display("dynsmic array ");
    
    arr2 = new[2];
    arr2[0] = 32;
    arr2[1]= 33;
    foreach(arr2[i])
      $display("arr i = %d  == %d ", i , arr2[i]);
    $display("size of array = %d ", arr2.size());
    arr2.delete();
     foreach(arr2[i])
      $display("arr i = %d  == %d ", i , arr2[i]);
    $display("size of array = %d ", arr2.size());

    
    
    
    
  end 
endmodule 
    
