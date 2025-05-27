class apb_driver extends uvm_driver #(apb_seq_item);

  //factory registration
  `uvm_component_utils(apb_driver)
   
  //declaring a virtual interface for driver
  virtual apb_intf vif;
       
  //declaring a handle for sequence item
  apb_seq_item  packet;

  //class constructor
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

 //build phase of driver 
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   //configuration database to get virtual interface handle
   if(!uvm_config_db #(virtual apb_intf) :: get (this, "", "vif", vif))
      begin
        `uvm_fatal(get_type_name(), "Unable to get the virtual interface");
     end

    //create seq_item packet
    packet = apb_seq_item::type_id::create("packet", this);
 endfunction

 //run phase of driver
 task run_phase(uvm_phase phase);
  repeat(2)@(vif.drv_cb);
    forever
      begin
      `uvm_info("DRIVER","Inside RUN_PHASE of apb driver",UVM_HIGH);
      seq_item_port.get_next_item(packet);
      drive();
      seq_item_port.item_done();
     end
    // `uvm_info("drv",$sformatf("%d %d",$time, vif.apb_write_data),UVM_HIGH)
 //  repeat(2)@(vif.drv_cb);
 endtask
  
//drive task 
 virtual task drive();
  repeat(1) @(vif.drv_cb);
 // @(vif.drv_cb) begin
  /* if(! vif.PRESETn)
     begin

      //if reset deasserted drive the signal as zero
    //  @(posedge vif.pclk);
       vif.transfer <= 'b0;
       vif.drv_cb.READ_WRITE <= 'bx;
       vif.apb_read_paddr <= 'b0;
       vif.apb_write_paddr <= 'b0;
       vif.apb_write_data <= 'b0;
     end
   else
   begin
*/
  // drive data
    @(vif.drv_cb)
    begin
    vif.drv_cb.transfer <= packet.transfer;
    vif.drv_cb.READ_WRITE <= packet.READ_WRITE;
    
    if (packet.transfer)
    begin
      if (packet.READ_WRITE)
        vif.drv_cb.apb_read_paddr <= packet.apb_read_paddr;
      else
      begin
        vif.drv_cb.apb_write_paddr <= packet.apb_write_paddr;
        vif.drv_cb.apb_write_data <= packet.apb_write_data;
      end
 
     

     `uvm_info("DRIVER","------------------------DRIVER DRIVING DATA-----------------------------------------",UVM_LOW); 
     packet.print();
     `uvm_info("DRIVER","------------------------------------------------------------------------------------",UVM_LOW);
end 
end
 endtask
endclass
