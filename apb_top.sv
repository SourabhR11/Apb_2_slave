
//import uvm_pkg::*;
//`include "uvm_macros.svh"
`include "defines.svh"
`include "apb_package.sv"
//`include "apb_intf.sv"
//`include "apb_slave.sv"


module apb_top;

  //declaring clock and reset
  bit pclk;
  bit presetn;
	
  //defining clock generation
  initial
  begin
    pclk <= 0;
    forever #5 pclk = ~pclk;  
  end

  //driving reset
  initial begin
    presetn = 0;
    #80;  presetn = 1;
    #100; presetn = 0;
    #20;  presetn = 1;
  end

  //Instantiating DUT
  
  //Instantiating Interface
  apb_intf intf(
	  .pclk(pclk),
	  .presetn(presetn));

  //defining configuration dtabase to access variables inside testbench components
  initial begin
      uvm_config_db#(virtual apb_intf.DRV)::set(null, "*", "vif_drv", intf.DRV);
      uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_in", intf.MON);
      uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_out", intf.MON);
	     
      $dumpfile("dump.vcd");
      $dumpvars();  
  end

  //Initiating the testbench
  initial
    begin
      run_test();
  end
endmodule
