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


////////// apb_write_slave1_sequence ////////////////////////
class apb_write_slave1 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_write_slave1)
  
  //class constructor
  function new (string name = "apb_write_slave1" );
    super.new(name);
  endfunction

  apb_seq_item item;

  virtual task body();
   repeat(10)begin
    item = apb_seq_item::type_id::create("item");
      `uvm_do_with(item,{
                        transfer == 1'b1;
                        READ_WRITE == 1'b0;
                        apb_write_paddr[8] == 0;
                        })
      `uvm_send(item);
//  `uvm_info("In seq",UVM_LOW);
    end
  endtask
endclass

////////// apb_write_slave2_sequence ////////////////////////
class apb_write_slave2 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_write_slave2)
  
  //class constructor
  function new (string name = "apb_write_slave2" );
    super.new(name);
  endfunction

  apb_seq_item item;

  virtual task body();
   repeat(10)begin
    item = apb_seq_item::type_id::create("item");
     /* `uvm_do_with(item,{
                        transfer == 1'b1;
                        READ_WRITE == 1'b0;
                        apb_write_paddr[8] == 1'b1;
                        })
      `uvm_send(item);
*/

        start_item(item);

    if(!(item.randomize()  with{item.transfer == 1; item.READ_WRITE == 0;item.apb_write_paddr[8] == 1; }))
      `uvm_error("SEQ","randomization failed"); 
   //  start_item(item);
    finish_item(item);
// `uvm_info("SEQ","In seq",UVM_LOW);
    end
  endtask
endclass
                       
                       
 
///////////// apb_read_slave1_sequence ////////////////////////////
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
                       apb_read_paddr[8] == 1'b0;
                      })
   `uvm_send(item);
   end
  endtask
endclass

///////////// apb_read_slave2_sequence ////////////////////////////
class apb_read_slave2 extends apb_seq;

  //factory registration
  `uvm_object_utils(apb_read_slave2)
  
  //class constructor
  function new (string name = "apb_read_slave2" );
    super.new(name);
  endfunction

  apb_seq_item item;
  virtual task body();
    repeat(5) begin
    item = apb_seq_item::type_id::create("item");
    `uvm_do_with(item,{
                       transfer == 1'b1;
                       READ_WRITE == 1'b1;
                       apb_read_paddr[8] == 1'b1;
                      })
   `uvm_send(item);
   end
  endtask
endclass

/////////// apb_write_read_slave1_sequence //////////////////////

class apb_write_read_slave1 extends apb_seq;
 
  `uvm_object_utils(apb_write_read_slave1)
 
  function new(string name = "apb_write_read_slave1");
    super.new(name);
  endfunction
 
   apb_seq_item item;

   bit [8:0]addr;

virtual task body();
    repeat(10)begin
     `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 0;item.apb_write_paddr[8] == 0;})
     `uvm_send(item);
     addr = item.apb_write_paddr;
 
    `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 1; item.apb_read_paddr == addr;})

     `uvm_send(item);
    end
  endtask
endclass

/////////// apb_write_read_slave2_sequence //////////////////////

class apb_write_read_slave2 extends apb_seq;
 
  `uvm_object_utils(apb_write_read_slave2)
 
  function new(string name = "apb_write_read_slave2");
    super.new(name);
  endfunction
 
   apb_seq_item item;

   bit [8:0]addr;

virtual task body();
    repeat(10)begin
      `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 0;item.apb_write_paddr[8] == 1;})
     `uvm_send(item);
     addr = item.apb_write_paddr;
 
    `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 1; item.apb_read_paddr == addr;})

     `uvm_send(item);
    end
  endtask
endclass

/////////// apb_10write_1read_slave1_sequence //////////////////////

class apb_10write_1read_slave1 extends apb_seq;
 
  `uvm_object_utils(apb_10write_1read_slave1)
 
  function new(string name = "apb_10write_1read_slave1");
    super.new(name);
  endfunction
 
   apb_seq_item item;

  bit [8:0] last_addr;

virtual task body();
   // repeat(10)begin
   for (int i = 0; i < 10; i++) begin
     `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 0; item.apb_write_paddr[8] == 0;})
      `uvm_send(item);
     
       last_addr = item.apb_write_paddr;
    end 
     `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 1; item.apb_read_paddr == last_addr;})
     `uvm_send(item);
    
   // end
  endtask
endclass

 /////////// apb_10write_1read_slave2_sequence //////////////////////

class apb_10write_1read_slave2 extends apb_seq;
 
  `uvm_object_utils(apb_10write_1read_slave2)
 
  function new(string name = "apb_10write_1read_slave");
    super.new(name);
  endfunction
 
   apb_seq_item item;

  bit [8:0] last_addr;

virtual task body();
   // repeat(10)begin
   for (int i = 0; i < 10; i++) begin
     `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 0; item.apb_write_paddr[8] == 1;})
      `uvm_send(item);
     
       last_addr = item.apb_write_paddr;
    end 
     `uvm_do_with(item, {item.transfer == 1; item.READ_WRITE == 1; item.apb_read_paddr == last_addr;})
     `uvm_send(item);
    
   // end
  endtask
endclass




