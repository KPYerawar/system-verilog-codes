module sv_arrays;

  // --- FIXED ARRAY ---
  // Size is decided at compile time, never changes. Like Verilog arrays.
  int fixed_arr [5];           // 5 elements, index 0 to 4
  bit [7:0] data_bus [4];      // 4 bytes, index 0 to 3

  // --- DYNAMIC ARRAY ---
  // Size is NOT known at compile time. You allocate it at runtime using 'new[]'.
  // This is your first taste of the OOP world that UVM lives in!
  int dyn_arr [];              // declared but has NO memory yet

  // --- A handy SV loop variable ---
  int i;

  initial begin

    // === FIXED ARRAY USAGE ===
    // Initialize using the apostrophe-brace syntax — very clean!
    fixed_arr = '{10, 20, 30, 40, 50};

    $display("--- Fixed Array ---");
    foreach (fixed_arr[i])           // 'foreach' is SV's gift — no more for(i=0;...)
      $display("  fixed_arr[%0d] = %0d", i, fixed_arr[i]);

    // === DYNAMIC ARRAY USAGE ===
    // Step 1: Allocate memory for 3 elements at runtime
    dyn_arr = new[3];
    dyn_arr[0] = 100;
    dyn_arr[1] = 200;
    dyn_arr[2] = 300;

    $display("--- Dynamic Array (size 3) ---");
    foreach (dyn_arr[i])
      $display("  dyn_arr[%0d] = %0d", i, dyn_arr[i]);

    // Step 2: Now RESIZE it to 5, preserving old data!
    dyn_arr = new[5] (dyn_arr);      // magic: resize + copy old values
    dyn_arr[3] = 400;
    dyn_arr[4] = 500;

    $display("--- Dynamic Array after resize to 5 ---");
    foreach (dyn_arr[i])
      $display("  dyn_arr[%0d] = %0d", i, dyn_arr[i]);

    // Step 3: Check the size anytime using .size()
    $display("Current size of dyn_arr = %0d", dyn_arr.size());

    // Step 4: Free the memory when done
    dyn_arr.delete();
    $display("After delete, size = %0d", dyn_arr.size()); // prints 0

  end

endmodule
