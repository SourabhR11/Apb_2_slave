class apb_active_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(apb_active_agent)

  //handle for sequencer, driver and input monitor
  apb_seqr seqr_h;
  apb_driver drv_h;
  apb_ip_mon in_mon_h;

  //class constructor
  function new(string name = "apb_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase for active agent
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create the instances of sequencer, driver, monitor.
    seqr_h = apb_seqr::type_id::create("seqr_h", this);
    drv_h = apb_driver::type_id::create("drv_h", this);
    in_mon_h = apb_ip_mon::type_id::create("in_mon_h", this);
  endfunction

  //connect phase to connect sequencer and driver
  function void connect_phase(uvm_phase phase);
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction
endclass  
