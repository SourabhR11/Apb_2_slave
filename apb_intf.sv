
interface apb_intf(input bit pclk, input bit presetn);

  

  //define signals as logic
  logic transfer;
  logic read_write;
  logic [`AW-1:0] apb_write_paddr;
  logic [`AW-1:0] apb_read_paddr;
  logic [`DW-1:0] apb_write_data;
  logic [`DW-1:0] apb_read_data_out;

  //clocking block for driver
  clocking drv_cb @(posedge pclk);
    default input #0 output #0;
    output transfer;
    output read_write;
    output apb_write_paddr;
    output apb_read_paddr;
    output apb_write_data;
    input apb_read_data_out;
  endclocking

  //clocking block for monitor
  clocking mon_cb @(posedge pclk);
    default input #0 output #0;
    input transfer;
    input read_write;
    input apb_write_paddr;
    input apb_read_paddr;
    input apb_write_data;  
    input apb_read_data_out;
  endclocking

  //modport for driver and monitor
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);
endinterface


    
    
