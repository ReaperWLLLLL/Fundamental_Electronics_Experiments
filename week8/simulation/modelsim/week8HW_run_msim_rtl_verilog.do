transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/software/FPGA/workplace/week8/task2_2 {G:/software/FPGA/workplace/week8/task2_2/task2_2_top.v}

vlog -vlog01compat -work work +incdir+G:/software/FPGA/workplace/week8/task2_2 {G:/software/FPGA/workplace/week8/task2_2/tb_task2_2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone10lp_ver -L rtl_work -L work -voptargs="+acc"  tb_task2_2

add wave *
view structure
view signals
run -all
