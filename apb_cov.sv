`uvm_analysis_imp_decl(_ip_mon)
`uvm_analysis_imp_decl(_op_mon)

class apb_cov extends uvm_subscriber #(apb_seq_item);
   `uvm_component_utils(apb_cov)
    
  uvm_analysis_imp_ip_mon#(apb_seq_item, apb_coverage) ip_cov_imp;
  uvm_analysis_imp_op_mon#(apb_seq_item, apb_coverage) op_cov_imp;

    apb_seq_item ip_seq;
    apb_seq_item op_seq;
  
    covergroup fun_cov_in;
      coverpoint ip_seq.read_write {
        bins i_read_write_0 = {1'b0};
        bins i_read_write_1 = {1'b1};
      }
      coverpoint ip_seq.transfer {
         bins i_transfer_0 = {1'b0};
         bins i_transfer_1 = {1'b1};
      }
      coverpoint ip_seq.apb_write_paddr {
        bins i_write_paddr_low = {[:]};
        bins i_write_paddr_mid = {[:]};
        bins i_write_paddr_high = {[:]};
      }
      coverpoint ip_seq.apb_read_paddr {
         bins i_read_paddr_low = {[8'h00:8'h03],[8'h08:8'h0b]};
         bins i_read_paddr_mid = {[8'h04:8'h07]};
         bins i_read_paddr_high = {[8'h0c:8'h0f],[8'h10:8'h13]};
      }

      coverpoint ip_seq.apb_write_data[];
      
    endgroup
    
    covergroup fun_cov_op;
      
      coverpoint op_seq.apb_read_data_out[]; 
      
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
