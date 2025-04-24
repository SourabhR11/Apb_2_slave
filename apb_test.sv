
class apb_test extends uvm_test;

  //factory registration
  `uvm_component_utils(apb_test)

  //handle for environment class
  apb_env env_h;

  //class constructor
  function new(string name = "apb_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase of test
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //Create the environment handle
    env_h = apb_env::type_id::create("env_h", this);
  endfunction 
  
  //end of eloboration phase of test
  virtual function void end_of_elaboration();
     uvm_top.print_topology();
  endfunction
endclass
