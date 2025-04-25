
class apb_op_mon extends uvm_monitor;

  //Registering output monitor of active agent to factory
  `uvm_component_utils(apb_op_mon)
   
  //Declaring virtual interface
  virtual apb_intf vif;

  //declaring analysis port for output monitor to coverage/scoreboard connection
  uvm_analysis_port #(apb_seq_item) op_mon_port;

  //declaring handle for sequence item
  apb_seq_item packet;
	
  //class constructor
  function new(string name = "apb_op_monitor", uvm_component parent);
    super.new(name, parent);

    //create instance of analysis port 
    op_mon_port = new("op_mon_port", this);
  endfunction
  
  //build phase of output monitor
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    packet = apb_seq_item::type_id::create("packet");
    //configuration database to get virtual interface	  
    if(!uvm_config_db #(virtual apb_intf) :: get(this, "", "vif", vif))
      `uvm_fatal("monitor", "Unable to  virtual interface")
  endfunction

  //run phase of output monitor	    
  task run_phase(uvm_phase phase);
   repeat(1)@(vif.mon_cb);
   `uvm_info("OP MONITOR","Inside run phase of op monitor",UVM_HIGH);
   forever begin
     @(vif.mon_cb)
  
       //capturing data from the dut in the sequence item packet through virtual interface  
       packet.apb_read_data_out = vif.mon_cb.apb_read_data_out; 

        //write method of output monitor
       op_mon_port.write(packet);

       `uvm_info("OUTPUT_MONITOR","---------------------Output monitor sending data-----------------------------------",UVM_LOW);
       packet.print();
       `uvm_info("OUTPUT_MONITOR","-----------------------------------------------------------------------------------",UVM_LOW); 
       repeat(2)@(vif.mon_cb);    
end
  endtask
endclass
   
	
