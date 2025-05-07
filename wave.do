onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /apb_top/dut/PCLK
add wave -noupdate /apb_top/dut/PRESETn
add wave -noupdate /apb_top/dut/transfer
add wave -noupdate /apb_top/dut/READ_WRITE
add wave -noupdate /apb_top/dut/apb_write_paddr
add wave -noupdate /apb_top/dut/apb_write_data
add wave -noupdate /apb_top/dut/apb_read_paddr
add wave -noupdate /apb_top/dut/PSLVERR
add wave -noupdate /apb_top/dut/apb_read_data_out
add wave -noupdate /apb_top/dut/PWDATA
add wave -noupdate /apb_top/dut/PRDATA
add wave -noupdate /apb_top/dut/PRDATA1
add wave -noupdate /apb_top/dut/PRDATA2
add wave -noupdate /apb_top/dut/PADDR
add wave -noupdate /apb_top/dut/PREADY
add wave -noupdate /apb_top/dut/PREADY1
add wave -noupdate /apb_top/dut/PREADY2
add wave -noupdate /apb_top/dut/PENABLE
add wave -noupdate /apb_top/dut/PSEL1
add wave -noupdate /apb_top/dut/PSEL2
add wave -noupdate /apb_top/dut/PWRITE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {72 ns}
