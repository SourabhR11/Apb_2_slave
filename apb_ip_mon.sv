class apb_ip_mon extends uvm_monitor;

  //Registering input monitor of active agent to factory
  `uvm_component_utils(apb_ip_mon)

  //declaring virtual interface 
  virtual apb_intf vif;

  //declaring analysis port for input monitor to coverage/scoreboard
  uvm_analysis_port #(apb_seq_item) ip_mon_port;

  //declaring handle for sequence item
  apb_seq_item packet;

  //class constructor
  function new(string name = "apb_ip_mon", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  //build phase of input monitor	
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //configuration database to get virtual interface handle
    if(!uvm_config_db #(virtual apb_intf) :: get(this, "", "vif_mon_in", vif))
       `uvm_fatal("Input_Monitor", "Unable to get virtual interface")

    //create instance of analsis port    
    ip_mon_port = new("ip_mon_port", this);
  endfunction

  //run phase of input monitor	
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.mon_cb)

        //capturing data from virtual interface in the sequence item packet
        packet = apb_seq_item::type_id::create("packet")
        packet.read_write = vif.mon_cb.read_write;
        packet.transfer = vif.mon_cb.transfer;
        packet.apb_read_paddr = vif.mon_cb.apb_read_paddr;
        packet.apb_write_paddr = vif.mon_cb.apb_write_paddr;
        packet.apb_write_data = vif.mon_cb.apb_write_data;

        //write method of analysis port
        ip_mon_port.write(packet);

    
	 
  endtask
endclass
   	

		
	
