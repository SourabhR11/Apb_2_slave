
interface apb_intf(input bit PCLK, input bit PRESETn);

  

  //define signals as logic
  logic transfer;
  logic READ_WRITE;
  logic [`AW-1:0] apb_write_paddr;
  logic [`AW-1:0] apb_read_paddr;
  logic [`DW-1:0] apb_write_data;
  logic [`DW-1:0] apb_read_data_out;

  //clocking block for driver
  clocking drv_cb @(posedge PCLK);
    default input #0 output #0;
    output transfer;
    output READ_WRITE;
    output apb_write_paddr;
    output apb_read_paddr;
    output apb_write_data;
    input apb_read_data_out;
  endclocking

  //clocking block for monitor
  clocking mon_cb @(posedge PCLK);
    default input #0 output #0;
    input transfer;
    input READ_WRITE;
    input apb_write_paddr;
    input apb_read_paddr;
    input apb_write_data;  
    input apb_read_data_out;
  endclocking

  //modport for driver and monitor
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);

///////// Assertion  Properties ///////////////

//parametric property to check signal is not X/Z
property ppt_signal_stability (signal) ;
   @(posedge PCLK) disable iff(!PRESETn)
      !$isunknown(signal) ;
endproperty 

//check signal stability
transfer_never_x    : assert property (ppt_signal_stability(transfer)) 
                          $info("[%0t] Info: transfer is valid.", $time) ;
                    else $error("[%0t] Error! transfer is unknown (=X/Z)", $time) ;

READ_WRITE_never_x    : assert property (ppt_signal_stability(READ_WRITE)) 
                          $info("[%0t] Info: READ_WRITE is valid.", $time) ;
                    else $error("[%0t] Error! READ_WRITE is unknown (=X/Z)", $time) ;

apb_write_paddr_never_x    : assert property (ppt_signal_stability(apb_write_paddr)) 
                          $info("[%0t] Info: apb_write_paddr is valid.", $time) ;
                    else $error("[%0t] Error! apb_write_paddr is unknown (=X/Z)", $time) ;

apb_read_paddr_never_x    : assert property (ppt_signal_stability(apb_read_paddr)) 
                          $info("[%0t] Info: apb_read_paddr is valid.", $time) ;
                    else $error("[%0t] Error! apb_read_padr is unknown (=X/Z)", $time) ;

apb_write_data_never_x   : assert property (ppt_signal_stability(apb_write_data)) 
                          $info("[%0t] Info: apb_write_data is valid.", $time) ;
                    else $error("[%0t] Error! apb_write_data is unknown (=X/Z)", $time) ;

apb_read_data_out_never_x    : assert property (ppt_signal_stability(apb_read_data_out)) 
                          $info("[%0t] Info: apb_read_data_out is valid.", $time) ;
                    else $error("[%0t] Error! apb_read_data_out is unknown (=X/Z)", $time) ;


//check write address stability

property ppt_write_addr_stability;
    @(posedge PCLK) disable iff (!PRESETn)
      transfer && !READ_WRITE |=> $stable(apb_write_paddr);
  endproperty
 
  write_address_stability: assert property (ppt_write_addr_stability)
    $display("WRITE_ADDRESS_STABILITY: ASSERTION PASS");
  else
    $error("WRITE_ADDRESS_STABILITY: ASSERTION FAIL");


//check read address stability

property ppt_read_addr_stability;
    @(posedge PCLK) disable iff (!PRESETn)
      transfer && READ_WRITE |=> $stable(apb_read_paddr);
  endproperty
 
  read_address_stability: assert property (ppt_read_addr_stability)
    $display("READ_ADDRESS_STABILITY: ASSERTION PASS");
  else
    $error("READ_ADDRESS_STABILITY: ASSERTION FAIL");

endinterface



   
    
