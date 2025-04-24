class apb_seqr extends uvm_sequencer#(apb_seq_item);

  //Factory registration
  `uvm_component_utils(apb_seqr)
 
  //class Constructor
  function new (string name="apb_seqr",uvm_component parent=null);
    super.new(name,parent);
  endfunction
endclass
