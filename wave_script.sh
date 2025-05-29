#compile
vlog apb_top.sv

# Simulate with a specific test
vsim -novopt -suppress 12110 apb_top 

