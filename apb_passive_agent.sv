class apb_passive_agent extends uvm_agent;
 
  //factory registration
  `uvm_component_utils(apb_passive_agent)

  //handle for output monitor
  apb_op_mon out_mon_h;

  //class constructor
  function new(string name = "apb_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase of passive agent
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  //create the instance of output monitor
  out_mon_h = apb_op_mon::type_id::create("out_mon_h", this);
  endfunction
 
endclass
