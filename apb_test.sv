
class apb_test extends uvm_test;

  //factory registration
  `uvm_component_utils(apb_test)

  //handle for environment class
  apb_env env_h;
  
  //handle for sequence
  apb_seq seq_h;

  //class constructor
  function new(string name = "apb_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase of test
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //Create the environment handle
    env_h = apb_env::type_id::create("env_h", this);
    seq_h = apb_seq::type_id::create("seq_h",this);

  endfunction 
  
  //end of eloboration phase of test
  virtual function void end_of_elaboration();
     uvm_top.print_topology();
  endfunction

  task run_phase (uvm_phase phase);
    
   // seq_h = apb_seq::type_id::create("seq_h");
    phase.raise_objection(this);
    seq_h.start(env_h.active_h.seqr_h);
    phase.drop_objection(this);
  endtask
endclass

///////////test case: apb_write_slave1 /////////////////////
class apb_write_slave1_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_write_slave1_test)

  //sequence handle
  apb_write_slave1 write_slave1_h;
   
  //class constructor  
  function new(string name = "apb_write_slave1_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // write_slave1_h = apb_write_slave1::type_id::create("write_slave1_h");
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    write_slave1_h = apb_write_slave1::type_id::create("write_slave1_h");
    write_slave1_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30);
  endtask
endclass

///////////test case: apb_write_slave2 /////////////////////
class apb_write_slave2_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_write_slave2_test)

  //sequence handle
  apb_write_slave2 write_slave2_h;
   
  //class constructor  
  function new(string name = "apb_write_slave2_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // write_slave2_h = apb_write_slave2::type_id::create("write_slave2_h");
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    write_slave2_h = apb_write_slave2::type_id::create("write_slave2_h");
    write_slave2_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30);
  endtask
endclass

///////////test case: apb_read_slave1 /////////////////////
class apb_read_slave1_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_read_slave1_test)

  //sequence handle
  apb_read_slave1 read_slave1_h;
   
  //class constructor  
  function new(string name = "apb_read_slave1_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    read_slave1_h = apb_read_slave1::type_id::create("read_slave1_h");
    read_slave1_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30);
  endtask
endclass

///////////test case: apb_read_slave2 /////////////////////
class apb_read_slave2_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_read_slave2_test)

  //sequence handle
  apb_read_slave2 read_slave2_h;
   
  //class constructor  
  function new(string name = "apb_read_slave2_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    read_slave2_h = apb_read_slave2::type_id::create("read_slave2_h");
    read_slave2_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30);
  endtask
endclass


///////////test case: apb_write_read_slave1 /////////////////////
class apb_write_read_slave1_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_write_read_slave1_test)

  //sequence handle
  apb_write_read_slave1 write_read_slave1_h;
   
  //class constructor  
  function new(string name = "apb_write_read_slave1_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // write_slave1_h = apb_write_slave1::type_id::create("write_slave1_h");
  endfunction
  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

   write_read_slave1_h = apb_write_read_slave1::type_id::create("write_read_slave1_h");
    write_read_slave1_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
endclass

///////////test case: apb_write_read_slave2 /////////////////////
class apb_write_read_slave2_test extends apb_test;

  //factory registration
  `uvm_component_utils(apb_write_read_slave2_test)

  //sequence handle
  apb_write_read_slave2 write_read_slave2_h;
   
  //class constructor  
  function new(string name = "apb_write_read_slave2_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // write_slave2_h = apb_write_slave2::type_id::create("write_slave2_h");
  endfunction


  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    write_read_slave2_h = apb_write_read_slave2::type_id::create("write_read_slave2_h");
    write_read_slave2_h.start(env_h.active_h.seqr_h);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask


endclass



