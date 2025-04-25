class apb_seq_item extends uvm_sequence_item;

  //declare the input signal as rand variable 
  rand bit transfer;                   // 1 = Start transaction, 0 = Idle
  rand bit read_write;                 // 1 = Read operation, 0 = Write operation
  rand bit [`AW-1:0] apb_write_paddr;  // Address for Write operation
  rand bit [`AW-1:0] apb_read_paddr;   // Address for Read operation
  rand bit [`DW-1:0] apb_write_data;   // Data to be written during Write
  bit [`DW-1:0] apb_read_data_out;     // Data received from slave after read

  
  //uvm fsctory registration and field macros
  `uvm_object_utils_begin(apb_seq_item)
  `uvm_field_int (read_write, UVM_DEFAULT)
  `uvm_field_int (apb_write_paddr, UVM_DEFAULT)
  `uvm_field_int (apb_read_paddr, UVM_DEFAULT)
  `uvm_field_int (apb_write_data, UVM_DEFAULT)
  `uvm_field_int (apb_read_data_out, UVM_DEFAULT)
  `uvm_object_utils_end
  
  //class constructor
  function new (string name = "apb_seq_item");
    super.new(name);
  endfunction

  
  constraint slave_sel { soft apb_write_paddr[8] dist {0  := 50, 1 := 50};}

  constraint deassert_transfer {if(! transfer ) {
    read_write == 0;
    apb_read_paddr == 0;
    apb_write_paddr == 0;
    apb_read_data_out == 0;
    apb_write_data == 0;
    }
  }

  
  constraint write_addr_range {if(transfer == 1 && read_write == 1)
                                 apb_write_paddr inside {[0:511]};}
 
  constraint read_addr_range {if(transfer == 1 && read_write == 1)
                                apb_read_paddr inside {[0:511]};}


endclass
