module struct_intro ;
typedef struct packed { //deftype ued to name the struct ////struce //packed ensure to store bits continously 
logic [7:0] r ;
logic [7:0] g ;
logic [7:0 ] b ;
} pixel_s;   //name of struct

pixel_s first_pixel;   //object crwation 

initial begin 
//// method to asssign direcy by field 
//first_pixel.r = 8'h01	;
//first_pixel.g = 8'hAA;
//first_pixel.b = 8'hEB;

//method 2 assign whole by singleline 
//first_pixel = 24'h01AAEB;

//method3 to bind by veriable name
//first_pixel = '{r:16,g:19,b:255};

//method4 direct by position 
first_pixel = '{33 , 1100 , 1111};
$display (" full pixel = %h & value of red " , first_pixel , first_pixel.r);
end endmodule 
