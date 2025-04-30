
//import uvm_pkg::*;
//`include "uvm_macros.svh"
`include "defines.svh"
`include "apb_package.sv"
//`include "apb_intf.sv"


module apb_top;

  //declaring clock and reset
  bit PCLK;
  bit PRESETn;

  //instantiate the dut
  APB_Protocol dut (
  .PCLK(PCLK),.PRESETn(PRESETn),.transfer(transfer),.READ_WRITE(READ_WRITE),.apb_write_paddr(apb_write_paddr),.apb_write_data(apb_write_data),.apb_read_paddr(apb_read_paddr),.apb_read_data_out(apb_read_data_out));
	
  //defining clock generation
<<<<<<< HEAD
  initial  begin
    pclk <= 0;
    forever #5 pclk = ~pclk;  
=======
  initial
  begin
    PCLK <= 0;
    forever #5 PCLK = ~PCLK;  
>>>>>>> ed76208aec6fa93b4cc8bebfdef21831106f481b
  end

  //driving reset
  initial begin
//    PRESETn = 0;
      PRESETn = 1;
   

  end

  //Instantiating DUT
  
  //Instantiating Interface
  apb_intf intf(
	  .PCLK(PCLK),
	  .PRESETn(PRESETn));

  //defining configuration dtabase to access variables inside testbench components
  initial begin
      uvm_config_db#(virtual apb_intf)::set(null, "*", "vif", intf);
     // uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_in", intf.MON);
      //uvm_config_db#(virtual apb_intf.MON)::set(null, "*", "vif_mon_out", intf.MON);
	     
      $dumpfile("dump.vcd");
      $dumpvars();  
  end

  //Initiating the testbench
  initial  begin
      run_test("apb_read_slave1_test");
  end
endmodule
