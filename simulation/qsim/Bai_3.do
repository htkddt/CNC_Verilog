onerror {quit -f}
vlib work
vlog -work work Bai_3.vo
vlog -work work Bai_3.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Bai_3_vlg_vec_tst
vcd file -direction Bai_3.msim.vcd
vcd add -internal Bai_3_vlg_vec_tst/*
vcd add -internal Bai_3_vlg_vec_tst/i1/*
add wave /*
run -all
