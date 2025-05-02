`uvm_analysis_imp_decl(_ip)
`uvm_analysis_imp_decl(_op)

class apb_sb extends uvm_scoreboard;

  // Registering scoreboard with factory
  `uvm_component_utils(apb_sb)

  // Declaring virtual interface
  virtual apb_intf vif;

  apb_seq_item exp_trans;
  apb_seq_item act_trans;

  // Declaring analysis port for scoreboard to input monitor communication
  uvm_analysis_imp_ip #(apb_seq_item, apb_sb) ip_scb_imp;

  // Declaring analysis port for scoreboard to output monitor communication
  uvm_analysis_imp_op #(apb_seq_item, apb_sb) op_scb_imp;

  
  apb_seq_item  out_queue[$];
  apb_seq_item  in_queue[$];

  logic [`DW-1:0] apb_mem [511:0];
  
  int pass = 0;
  int fail = 0;


  //class constructor
  function new(string name = "apb_sb", uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase of score board  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create instance of implementation port
    ip_scb_imp = new("ip_scb_imp", this);
    op_scb_imp = new("op_scb_imp", this);

    //configuration database to get virtual interface handle
    if (!uvm_config_db#(virtual apb_intf)::get(this,"", "vif",vif))
       `uvm_fatal("APB_SB", "APB interf.CE handle not found in config database!")
  endfunction

  //write function for expected values   
  function void write_ip(apb_seq_item in_mon);
    in_queue.push_back(in_mon);
    `uvm_info("Scoreboard",$sformatf("EXPECTED TRANSACTION: Queue size = %0h | READ_WRITE = %0h | transfer = %0h | apb_write_paddr = %0h | apb_write_data = %0h | apb_read_paddr = %0h | apb_read_data_out = %h ",in_queue.size(),in_mon.READ_WRITE,in_mon.transfer,in_mon.apb_write_paddr,in_mon.apb_write_data,in_mon.apb_read_paddr,in_mon.apb_read_data_out),UVM_LOW)
  $display("---------------------------------------------------------------------------------------");
  endfunction
  
  //write function of actual values
  function void write_op(apb_seq_item out_mon);
    out_queue.push_back(out_mon);
     `uvm_info("Scoreboard",$sformatf("ACTUAL TRANSACTION: Queue size = %0h | READ_WRITE = %0h | transfer = %0h | apb_write_paddr = %0h | apb_write_data = %0h | apb_read_paddr = %0h | apb_read_data_out = %h ",out_queue.size(),out_mon.READ_WRITE,out_mon.transfer,out_mon.apb_write_paddr,out_mon.apb_write_data,out_mon.apb_read_paddr,out_mon.apb_read_data_out),UVM_LOW)
  $display("---------------------------------------------------------------------------------------");

  endfunction

  //run phase of score board
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      exp_trans=apb_seq_item::type_id::create("exp_trans",this);
      act_trans=apb_seq_item::type_id::create("act_trans",this);

      wait(in_queue.size() > 0 && out_queue.size() > 0);

        exp_trans = in_queue.pop_front();
        act_trans = out_queue.pop_front();

        if(exp_trans.transfer == 1)
          begin
            if(exp_trans.READ_WRITE == 0)
              begin
                apb_mem[exp_trans.apb_write_paddr] =exp_trans.apb_write_data;
                   end      
               else
                  begin
                    exp_trans.apb_read_data_out =  apb_mem[exp_trans.apb_read_paddr];
                  end
              end
       compare(exp_trans,act_trans);
     end
    endtask

  virtual function void compare(apb_seq_item exp_trans,apb_seq_item act_trans);
    if(exp_trans.READ_WRITE)
      begin
        if((exp_trans.apb_write_data == act_trans.apb_write_data) && (exp_trans.apb_write_paddr == act_trans.apb_write_paddr))
          begin
            `uvm_info("compare", $sformatf("-------------Test PASS------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h |  Actual apb_write_apddr = %0h ", exp_trans.apb_write_data, act_trans.apb_write_data, exp_trans.apb_write_paddr, act_trans.apb_write_paddr), UVM_LOW);
             pass++;
          end
        else
          begin
            `uvm_info("compare", $sformatf("-------------Test FAIL------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h  |  Expected apb_write_paddr =%0h | Actual apb_write_apddr = %0h ", exp_trans.apb_write_data, act_trans.apb_write_data, exp_trans.apb_write_paddr, act_trans.apb_write_paddr), UVM_LOW);
             fail++;
          end
      end
    
    else
      begin
             if((exp_trans.apb_read_data_out == act_trans.apb_read_data_out) && (exp_trans.apb_read_paddr == act_trans.apb_read_paddr))
          begin
            `uvm_info("compare", $sformatf("-------------Test PASS------------\n Expected apb_read_data = %0h  | Actual apb_read_data = %0h  | Expected apb_read_paddr =%0h  | Actual apb_write_apddr = %0h ", exp_trans.apb_write_data, act_trans.apb_write_data, exp_trans.apb_write_paddr, act_trans.apb_write_paddr), UVM_LOW);
             pass++;
          end
        else
          begin
            `uvm_info("compare", $sformatf("-------------Test FAIL------------\n Expected apb_write_data = %0h  | Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h | Actual apb_write_apddr = %0h ", exp_trans.apb_write_data, act_trans.apb_write_data, exp_trans.apb_write_paddr, act_trans.apb_write_paddr), UVM_LOW);
             fail++;
          end
      end
  endfunction
            
            
    function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    if (fail > 0) begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE);
      `uvm_info(get_type_name(), $sformatf("       TEST FAIL COUNT:  %0d     ", fail), UVM_NONE);
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE);
    end

    if (pass > 0) begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE);
      `uvm_info(get_type_name(), $sformatf("      TEST PASS COUNT:  %0d     ", pass), UVM_NONE);
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE);
    end
  endfunction
                  
   
endclass


 

