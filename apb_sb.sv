`uvm_analysis_imp_decl(_ip)
`uvm_analysis_imp_decl(_op)

class apb_sb extends uvm_scoreboard;

  // Registering scoreboard with factory
  `uvm_component_utils(apb_sb)

  // Declaring virtual interface
  virtual apb_interface vif;

  // Declaring analysis port for scoreboard to input monitor communication
  uvm_analysis_imp_ip #(apb_seq_item, apb_sb) ip_scb_imp;

  // Declaring analysis port for scoreboard to output monitor communication
  uvm_analysis_imp_op #(apb_seq_item, apb_sb) op_scb_imp;

  // Declaring variables for storing match and mismatch count
  apb_seq_item  expected_op[$];
  apb_seq_item  actual_op[$];

  //class constructor
  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase of score board  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create instance of implementation port
    ip_scb_imp = new("ip_scb_imp", this);
    op_scb_imp = new("op_scb_imp", this);

    //configuration database to get virtual interface handle
    if (!uvm_config_db#(virtual apb_intf)::get(this,"", "vif_mon_in",vif))
       `uvm_fatal("APB_SB", "APB interf.CE handle not found in config database!")
  endfunction

  //write function for expected values   
  function void write_ip(apb_seq_item in_mon);
    expected_op.push_back(in_mon);
    `uvm_info("Scoreboard",$sformatf("Got expected trnasaction: Queue size = %0d | read_write = %0b | transfer = %0b | apb_write_paddr = %0h | apb_write_data = %0b | apb_read_paddr = %0h | apb_read_data_out = %ob ",expected_op.size(),in_mon.read_write,in_mon.transfer,in_mon.apb_write_paddr,in_mon.apb_write_data,in_mon.apb_read_paddr,in_mon.apb_read_data_out),UVM_LOW)
  $display("---------------------------------------------------------------------------------------");
  endfunction
  
  //write function of actual values
  function void write_op(apb_seq_item out_mon);
    actual_op.push_back(out_mon);
     `uvm_info("Scoreboard",$sformatf("Got actual  trnasaction: Queue size = %0d | read_write = %0b | transfer = %0b | apb_write_paddr = %0h | apb_write_data = %0b | apb_read_paddr = %0h | apb_read_data_out = %ob ",expected_op.size(),in_mon.read_write,in_mon.transfer,in_mon.apb_write_paddr,in_mon.apb_write_data,in_mon.apb_read_paddr,in_mon.apb_read_data_out),UVM_LOW)
  $display("---------------------------------------------------------------------------------------");

  endfunction

  //run phase of score board
  task run_phase(uvm_phase phase);


  endtask
endclass


 

