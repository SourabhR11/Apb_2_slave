class apb_env extends uvm_env;
 
  `uvm_component_utils(apb_env)
 
  apb_active_agent active_h;
  apb_passive_agent passive_h;
  apb_sb sb_h;
  apb_cov cov_h;
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_h = apb_active_agent::type_id::create("active_h", this);
    passive_h = apb_passive_agent::type_id::create("passive_h", this);
    sb_h = apb_sb::type_id::create("sb_h", this);
    cov_h = apb_cov::type_id::create("cov_h", this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   active_h.in_mon_h.ip_mon_port.connect(sb_h.ip_scb_imp);
   passive_h.out_mon_h.op_mon_port.connect(sb_h.op_scb_imp);
   active_h.in_mon_h.ip_mon_port.connect(cov_h.ip_cov_imp);
   passive_h.out_mon_h.op_mon_port.connect(cov_h.op_cov_imp);

  endfunction
 
endclass
