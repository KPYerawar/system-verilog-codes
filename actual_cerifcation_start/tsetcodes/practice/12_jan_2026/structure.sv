module structure;

typedef struct packed  {
logic [3:0] r ;
logic [3:0] g ;
int a ;
} student;

student s1;
initial begin 
s1.r = 4'b1100 ;
s1.g = 0100;


$display ("data of s1 student is = r = %b , g = %b  " , s1.r , s1.g  );
s1 = '{ 4'b0101 , 4'b1100 , 1};
$display ("data of s1 student is = r = %b , g = %b  " , s1.r , s1.g  );
//s1 = '{r: 4'b0011, g: 4'b1100};
$display ("data of s1 student is = r = %b , g = %b  " , s1.r , s1.g  );
s1 = '{1 ,1 ,0};
$display ("data of s1 student is = r = %b , g = %b  " , s1.r , s1.g  );

end 
endmodule  
