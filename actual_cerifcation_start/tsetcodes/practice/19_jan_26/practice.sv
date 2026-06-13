module practice;
class bankaccount ;
int balance = 0 ;


function void deposit(int amount ); 
 balance = balance + amount ;
 endfunction 
 
 function void getbalance (); 
 $display ("account balance == %d " ,balance ); 
 endfunction
  endclass
 bankaccount my_acc;

 initial begin 
 my_acc = new();
 my_acc.deposit(200);
my_acc.getbalance();
 my_acc.deposit(200);
 my_acc.getbalance();

end
endmodule 
 
 
