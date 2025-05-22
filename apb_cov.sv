`uvm_analysis_imp_decl(_ip_mon)
`uvm_analysis_imp_decl(_op_mon)

class apb_cov extends uvm_subscriber #(apb_seq_item);
   `uvm_component_utils(apb_cov)
    
  uvm_analysis_imp_ip_mon#(apb_seq_item, apb_cov) ip_cov_imp;
  uvm_analysis_imp_op_mon#(apb_seq_item, apb_cov) op_cov_imp;

    apb_seq_item ip_seq;
    apb_seq_item op_seq;
  
    covergroup fun_cov_in;

    apb_write_slave_select_cp: coverpoint ip_seq.apb_write_paddr[8] {
        bins i_apb_write_paddr_0 = {1'b0};
        bins i_apb_write_paddr_1 = {1'b1};
        
      }
     
    apb_read_slave_select_cp: coverpoint ip_seq.apb_read_paddr[8] {
        bins i_apb_read_paddr_0 = {1'b0};
        bins i_apb_read_paddr_1 = {1'b1};
        
      }
    apb_read_write_cp: coverpoint ip_seq.READ_WRITE {
        bins i_READ_WRITE_0 = {1'b0};
        bins i_READ_WRITE_1 = {1'b1};
      }

    apb_transfer_cp: coverpoint ip_seq.transfer {
         bins i_transfer_0 = {1'b0};
         bins i_transfer_1 = {1'b1};
      } 

    apb_write_paddr_cp: coverpoint ip_seq.apb_write_paddr {
        bins i_write_paddr_low = {[0:80]};
        bins i_write_paddr_mid = {[81:180]};
        bins i_write_paddr_high = {[181:256]};
      }

     apb_read_paddr_cp: coverpoint ip_seq.apb_read_paddr {
         bins i_read_paddr_low = {[0:80]};
         bins i_read_paddr_mid = {[81:180]};
         bins i_read_paddr_high = {[181:256]};
      }

     apb_write_data_cp: coverpoint ip_seq.apb_write_data {
         bins i_write_data_low = {[0:80]};
         bins i_write_data_mid = {[81:180]};
         bins i_write_data_high = {[181:255]};
      }

   //cross coverage
   
   apb_read_write_cp_X_apb_write_slave_sel_cp: cross apb_write_slave_select_cp,apb_read_write_cp;
 
   apb_read_write_cp_X_apb_read_slave_sel_cp: cross apb_read_slave_select_cp,apb_read_write_cp;

   apb_read_write_cp_X_apb_transfer_cp: cross apb_read_write_cp,apb_transfer_cp;

   apb_write_data_cp_X_apb_write_paddr_cp: cross apb_write_data_cp,apb_write_paddr_cp; 
  
      
  endgroup
    
  covergroup fun_cov_op;
     
       apb_read_data_cp: coverpoint ip_seq.apb_read_data_out {
         bins i_read_data_low = {[0:80]};
         bins i_read_data_mid = {[81:180]};
         bins i_read_data_high = {[181:255]};
      }


  endgroup

    real ip_cov_val, op_cov_val;
  
    function new(string name="apb_cov",uvm_component parent=null);
          super.new(name,parent);
          ip_cov_imp=new("ip_mon_imp",this);
          op_cov_imp=new("op_mon_imp",this);
      
          fun_cov_in =new();
          fun_cov_op =new();
    
    endfunction:new

    virtual function void write_ip_mon(apb_seq_item item);
      this.ip_seq = item; 
      fun_cov_in.sample();
    endfunction

    virtual function void write_op_mon(apb_seq_item item);
       this.op_seq= item;
       fun_cov_op.sample();
    endfunction
     

    virtual function void write(apb_seq_item t);
    endfunction

    virtual  function void extract_phase(uvm_phase phase);
          super.extract_phase(phase);
          
          ip_cov_val = fun_cov_in.get_coverage();
          op_cov_val = fun_cov_op.get_coverage();
        `uvm_info("COVERAGE",$sformatf("\n Input coverage is %f \n output coverage is %f",ip_cov_val,op_cov_val),UVM_LOW);
        endfunction
    

endclass
