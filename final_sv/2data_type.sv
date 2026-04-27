module data_types;

  // --- 2-state types (testbench friendly) ---
  bit        single_bit;       // just 0 or 1, like a clean switch
  bit [7:0]  byte_vec;         // 8-bit 2-state vector
  byte       signed_byte;      // same as bit[7:0] but SIGNED (-128 to 127)
  int        counter;          // 32-bit signed integer, very common in testbenches
  longint    big_number;       // 64-bit signed, useful for timestamps

  // --- 4-state type (design/interface signals) ---
  logic [7:0] design_signal;   // can hold X and Z, use for DUT signals

  initial begin
    // --- Demonstrate 2-state behavior ---
    single_bit = 1'b1;
    byte_vec   = 8'hFF;
    counter    = -100;         // int is signed, so negative values work!
    big_number = 64'd123456789;

    $display("single_bit  = %0b",   single_bit);
    $display("byte_vec    = %0h",   byte_vec);
    $display("counter     = %0d",   counter);    // prints -100
    $display("big_number  = %0d",   big_number);

    // --- Key learning: what happens with X in 2-state vs 4-state? ---
    design_signal = 8'hXX;    // 4-state: can store X (unknown)
    byte_vec      = 8'hXX;    // 2-state: X gets FORCED to 0 automatically!

    $display("--- After assigning X ---");
    $display("design_signal (logic) = %0h", design_signal); // shows x
    $display("byte_vec (bit[7:0])   = %0h", byte_vec);      // shows 0 !

  end

endmodule
