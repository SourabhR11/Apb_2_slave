
//import uvm_pkg::*;
//`include "uvm_macros.svh"
`include "defines.svh"
`include "apb_package.sv"
//`include "apb_intf.sv"


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
//    presetn = 0;
      presetn = 1;
   

  end

  //Instantiating DUT
  
  //Instantiating Interface
  apb_intf intf(
	  .pclk(pclk),
	  .presetn(presetn));

  //defining configuration dtabase to access variables inside testbench components
  initial begin
      uvm_config_db#(virtual apb_intf)::set(null, "*", "vif", intf);
     // uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_in", intf.MON);
      //uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_out", intf.MON);
	     
      $dumpfile("dump.vcd");
      $dumpvars();  
  end

  //Initiating the testbench
  initial
    begin
      run_test("apb_write_slave1_test");
  end
endmodule
