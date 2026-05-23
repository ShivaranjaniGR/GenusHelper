import os

def generate_genus_tcl(rtl_path, top_module, lib_path, sdc_path, run_dir, tcl_path):

    lib_dir = os.path.dirname(lib_path)

    with open(tcl_path, "w") as f:
        f.write(f"set_db init_lib_search_path {{{lib_dir}}}\n")
        f.write(f"set_db library {{{lib_path}}}\n\n")
        f.write(f"read_hdl {rtl_path}\n")
        f.write(f"elaborate {top_module}\n")
        f.write("check_design > check_design.rpt\n\n")

        f.write(f"read_sdc {sdc_path}\n\n")

        f.write("syn_generic\n")
        f.write("syn_map\n")
        f.write("syn_opt\n\n")

        f.write("report_timing > timing.rpt\n")
        f.write("report_area > area.rpt\n")
        f.write("report_power > power.rpt\n")
        f.write("report_qor > qor.rpt\n\n")

        f.write(f"write_hdl > {run_dir}/synth_netlist.v\n")
        f.write("exit\n")
