module queues_and_assoc;

  // --- QUEUE ---
  // Notice the [$] — that's the queue declaration syntax
  int my_queue [$];

  // --- ASSOCIATIVE ARRAY ---
  // The [string] means our KEY is a string type
  // The value stored is an int
  int error_count [string];

  // We can also use integer keys — very useful for address-based tracking
  string transaction_log [int];

  int i;

  initial begin

    // =====================
    // QUEUE OPERATIONS
    // =====================
    $display("--- Queue Demo ---");

    // push_back adds to the END of the queue (like joining a line)
    my_queue.push_back(10);
    my_queue.push_back(20);
    my_queue.push_back(30);
    $display("After 3 push_back, size = %0d", my_queue.size());

    // push_front adds to the BEGINNING (like cutting the line!)
    my_queue.push_front(5);
    $display("After push_front(5), front element = %0d", my_queue[0]);

    // Print every element using foreach
    foreach (my_queue[i])
      $display("  my_queue[%0d] = %0d", i, my_queue[i]);

    // pop_front removes AND returns the first element
    // This is how a scoreboard "consumes" an expected transaction
    $display("Popped from front: %0d", my_queue.pop_front());
    $display("After pop, size = %0d", my_queue.size());

    // You can also insert at a specific position
    my_queue.insert(1, 99);   // insert value 99 at index 1
    $display("After insert(1, 99):");
    foreach (my_queue[i])
      $display("  my_queue[%0d] = %0d", i, my_queue[i]);

    // =====================
    // ASSOCIATIVE ARRAY OPERATIONS
    // =====================
    $display("\n--- Associative Array Demo ---");

    // Store values with string keys — no pre-declaration of size needed!
    error_count["parity_error"]   = 3;
    error_count["timeout_error"]  = 1;
    error_count["overflow_error"] = 7;

    // Check if a key EXISTS before reading — very important habit!
    if (error_count.exists("parity_error"))
      $display("parity_error count = %0d", error_count["parity_error"]);

    // Iterate over ALL keys using 'foreach' — order is not guaranteed
    foreach (error_count[key])
      $display("  Error type: %-20s | Count: %0d", key, error_count[key]);

    // Integer-keyed associative array — great for memory maps
    transaction_log[32'h0000_1000] = "WRITE";
    transaction_log[32'h0000_2000] = "READ";
    transaction_log[32'h0000_1000] = "READ";  // overwrites previous entry

    $display("\n--- Transaction Log ---");
    foreach (transaction_log[addr])
      $display("  Address: 0x%0h -> %s", addr, transaction_log[addr]);

    // How many unique addresses were accessed?
    $display("Unique addresses tracked: %0d", transaction_log.num());

    // Delete a specific entry
    transaction_log.delete(32'h0000_2000);
    $display("After deleting 0x2000, entries remaining: %0d", transaction_log.num());

  end

endmodule
