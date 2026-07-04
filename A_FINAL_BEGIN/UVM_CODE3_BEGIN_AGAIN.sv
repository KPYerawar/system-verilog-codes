`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 09:22:43 AM
// Design Name: 
// Module Name: UVM_CODE3_BEGIN_AGAIN
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;
/* UVM MACROS LODING --- USED TO IMPORT READY MADE TOOLS CODE ETC */

`include "uvm_macros.svh"
/* THE UVM COMPONENTS ARE TOO BIG SO WE UAE THE SHORTCUTS TO IMPORT THEM 
         ` THS TICK USED TO  INDICATE THE SHORTCUT */
         
class my_driver extends uvm_driver ;
/* KIND OF POLYMORPHISM FR THE OUR DRIVER CLASS JINTS THE UVM BRIVER CLASS */

`uvm_component_utils (my_driver)
/* FACTORY REGESTRATION - THIS TELS THE UVM TO REGISTER OUR CALSS IN IT .
      ALSO IT HELP TO MAKE AUTOMATIC OBJECT DIRECTY INSTED OF THE NEW(); */
      
function new( string name = " my_driver" , uvm_component parent = null ) ;
/* THIS IS THE CONSTROCTOR RI=UNS 1ST WHEN THE OBJECT IS CREATED 
    PASSING THE COMPONENT NAME AND THE THE PARTNE F RIT THE PARENT CONCEPT IS NEW WE ARE NOT USING IT HERE SO KPPE IT NULL */
    
super.new(name , parent);
/*THIS TELLS UVM THAT THE CLASS I AM EXTENDING OVER ME THIS IS HIS NAME AND PARTNT */

endfunction 
endclass 
module UVM_CODE3_BEGIN_AGAIN(

    );
endmodule
