class apb_env extends uvm_env;
 
  `uvm_component_utils(apb_env)
 
  apb_active_agent active_h;
  apb_passive_agent passive_h;
  apb_sb sb_h;
  //apb_cov cov_h;
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_h = apb_active_agent::type_id::create("active_h", this);
    passive_h = apb_passive_agent::type_id::create("passive_h", this);
    sb_h = apb_sb::type_id::create("sb_h", this);
    //coverage_h = apb_coverage::type_id::create("coverage_h", this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    active_h.monitor_h.item_collected_port.connect(scoreboard_h.input_import);
    agent2_h.op_monitor_h.item_collected_port.connect(scoreboard_h.output_import);
    //agent1_h.monitor_h.item_collected_port.connect(coverage_h.analysis_import);
  endfunction
 
endclass
