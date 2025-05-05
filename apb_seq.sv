class apb_seq extends uvm_sequence #(apb_seq_item);
  //factory registration
  `uvm_object_utils(apb_seq)
   
  //delcaring a virtual interface for sequence
  virtual apb_intf vif;

  //class constructor 
  function new(string name = "apb_seq");
     super.new(name);
  endfunction

 //instance of sequence item
 apb_seq_item item;
  
 
 virtual task body();  
 
    
    //sequencer driver handshaking method
    item = apb_seq_item::type_id::create("item");
    wait_for_grant();
    item.randomize();
    send_request(item);
    wait_for_item_done();
 endtask
endclass


//apb_write sequence
class apb_write_slave1 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_write_slave1)
  
  //class constructor
  function new (string name = "apb_write_slave1" );
    super.new(name);
  endfunction

  apb_seq_item item;

  virtual task body();
    item = apb_seq_item::type_id::create("item");
    `uvm_do_with(item,{transfer == 1'b1;
                      READ_WRITE == 1'b0;
                       apb_write_paddr[8] == 1'b0;
                      })
  endtask
endclass
                       
 
//apb_read_sequence
class apb_read_slave1 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_read_slave1)
  
  //class constructor
  function new (string name = "apb_read_slave1" );
    super.new(name);
  endfunction

  apb_seq_item item;

  virtual task body();
    item = apb_seq_item::type_id::create("item");
    `uvm_do_with(item,{transfer == 1'b1;
                      READ_WRITE == 1'b1;
                       apb_write_paddr[8] == 1'b0;
                      // apb_read_data_out == 8'hff;
                      })
  endtask
endclass

/*
//apb_write_read_sequence

class apb_write_read_slave1 extends apb_seq;
 
  `uvm_object_utils(apb_write_read_slave1)
 
  function new(string name = "apb_write_read_slave1");
    super.new(name);
  endfunction : new
 
  apb_seq_item write_txn;
  apb_seq_item read_txn;
 
  virtual task body();
 
    // Create and randomize the write transaction
 
    write_txn = apb_seq_item::type_id::create("write_txn");
    if (!write_txn.randomize() with {
      write_txn.transfer == 1;
      write_txn.READ_WRITE == 0; // Write operation
      apb_write_paddr[8] == 1;
    }) 
      `uvm_error("SEQ", "Write transaction randomization failed")

 
    // Display write transaction details
    $display("WRITE ADDRESS == %h", write_txn.apb_write_paddr);
    $display("WRITE DATA    == %h", write_txn.apb_write_data);
 
    // Start and finish the write transaction
    start_item(write_txn);
    finish_item(write_txn);
 
    // Create the read transaction using the same address
    read_txn = apb_seq_item::type_id::create("read_txn");
    read_txn.transfer = 10;
    read_txn.READ_WRITE = 1; // Read operation
    read_txn.apb_read_paddr = write_txn.apb_write_paddr;
 
    // Start and finish the read transaction
    start_item(read_txn);
    finish_item(read_txn);
 
    // Optionally, compare the read data with the written data
    if (read_txn.apb_read_data_out !== write_txn.apb_write_data) begin
      `uvm_error("SEQ", $sformatf("Data mismatch: Written %h, Read %h",
                  write_txn.apb_write_data, read_txn.apb_read_data_out))
    end else begin
      `uvm_info("SEQ", $sformatf("Data match: %h", read_txn.apb_read_data_out), UVM_LOW)
    end
 
  endtask
 
endclass 

*/

class apb_write_read_slave1 extends apb_seq;
 
  `uvm_object_utils(apb_write_read_slave1)
 
  function new(string name = "apb_write_read_slave1");
   super.new(name);
  endfunction
 
 
  virtual task body();
    apb_write_slave1 wr_seq;
    apb_read_slave1  rd_seq;  
  //  repeat(2) begin
      `uvm_do(wr_seq)
  //  end
  //  repeat(2) begin
      `uvm_do(rd_seq)
   // end
  endtask


endclass
