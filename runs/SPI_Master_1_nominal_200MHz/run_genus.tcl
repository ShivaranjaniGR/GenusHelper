set_db init_lib_search_path {/home/userdata/22bec0985/llm_project/baseline_designs}
set_db library {/home/userdata/22bec0985/llm_project/baseline_designs/tcbn65gpluswcz_ccs.lib}

read_hdl /home/userdata/22bec0985/GenusHelper/rtl_source/SPI_Master_1.v
elaborate SPI_Master_1
check_design > check_design.rpt

read_sdc /home/userdata/22bec0985/GenusHelper/runs/SPI_Master_1_nominal_200MHz/constraints.sdc

syn_generic
syn_map
syn_opt

report_timing > timing.rpt
report_area > area.rpt
report_power > power.rpt
report_qor > qor.rpt

write_hdl > /home/userdata/22bec0985/GenusHelper/runs/SPI_Master_1_nominal_200MHz/synth_netlist.v
exit
