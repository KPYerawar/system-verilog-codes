module queues;
  int my_queue[$];//queue decleration syntax 
  
  int i ;
  initial begin 
    $display ("-----------queue dome -------------");
    my_queue.push_back(10);
    my_queue.push_back (20);
    my_queue.push_back(30);
    $display("length of my queue - %d ", my_queue.size());
    $display("length of my queue ");
    foreach(my_queue[i])
      $display("all elemets = my_queue[%d]  = %d", i , my_queue[i]);
    my_queue.push_front(100);
    $display("length of my queue - %d ", my_queue.size());
    $display("length of my queue ");
    foreach(my_queue[i])
      $display("all elemets = my_queue[%d]  = %d", i , my_queue[i]);
    $display(" poped eleement = %d", my_queue.pop_front());
    $display("after pop soze - %d ", my_queue.size());
    
    
    my_queue.insert(2, 290); // add 290 at 2 index (means 3dr position) position 
        foreach(my_queue[i])

          $display("all elemets after pop= my_queue[%d]  = %d", i , my_queue[i]);
    my_queue.push_front(100);
    $display("length of my queue - %d ",my_queue.size());
    $display("length of my queue ");
  end 
endmodule 
    
    
    
