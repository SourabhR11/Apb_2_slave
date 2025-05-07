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


////////// apb_write sequence ////////////////////////
class apb_write_slave1 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_write_slave1)
  
  //class constructor
  function new (string name = "apb_write_slave1" );
    super.new(name);
  endfunction

  apb_seq_item item;

  virtual task body();
   repeat(5)begin
    item = apb_seq_item::type_id::create("item");
      `uvm_do_with(item,{
                        transfer == 1'b1;
                        READ_WRITE == 1'b0;
                         apb_write_paddr[8] == 1'b0;
                        })
    end
  endtask
endclass
                       
 
///////////// apb_read_sequence ////////////////////////////
class apb_read_slave1 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_read_slave1)
  
  //class constructor
  function new (string name = "apb_read_slave1" );
    super.new(name);
  endfunction

  apb_seq_item item;
  virtual task body();
    repeat(5) begin
    item = apb_seq_item::type_id::create("item");
    `uvm_do_with(item,{
                       transfer == 1'b1;
                       READ_WRITE == 1'b1;
                       apb_write_paddr[8] == 1'b0;
                      })
   end
  endtask
endclass

/////////// apb_write_read_sequence //////////////////////

class apb_write_read_slave1 extends apb_seq;
 
  `uvm_object_utils(apb_write_read_slave1)
 
  function new(string name = "apb_write_read_slave1");
    super.new(name);
  endfunction : new
 
  apb_seq_item write_txn;
  apb_seq_item read_txn;

 
 
  virtual task body();
  // write_txn = apb_seq_item::type_id::create("write_txn");
  // read_txn = apb_seq_item::type_id::create("read_txn");

  `uvm_do_with(write_txn,{write_txn.transfer = 1'b1;write_txn.READ_WRITE = 1'b0; write_txn.apb_write_paddr[8] = 0;});
  
  write_txn.apb_write_paddr.rand_mode(0);
  
  `uvm_do_with(read_txn,{read_txn.transfer = 1'b1; read_txn.READ_WRITE = 1'b1; read_txn.apb_read_paddr = write_txn.apb_write_paddr;})
  endtask
 
endclass 

 


