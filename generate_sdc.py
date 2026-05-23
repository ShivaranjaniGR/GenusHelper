def generate_sdc(clock_port, frequency_mhz, setup_uncertainty, hold_uncertainty,
                 source_latency_max, source_latency_min, sdc_path):

    clk_period = 1000.0 / float(frequency_mhz)

    with open(sdc_path, "w") as f:
        f.write(f"set CLK_PERIOD {clk_period:.3f}\n\n")

        f.write("######## CLOCK ########\n")
        f.write(
            f"create_clock -name clk -period $CLK_PERIOD "
            f"-waveform \"0 [expr $CLK_PERIOD/2]\" [get_ports {clock_port}]\n\n"
        )

        f.write("######## CLOCK UNCERTAINTY ########\n")
        f.write(f"set_clock_uncertainty -setup {setup_uncertainty} [get_clocks clk]\n")
        f.write(f"set_clock_uncertainty -hold  {hold_uncertainty} [get_clocks clk]\n\n")

        f.write("######## CLOCK SOURCE LATENCY ########\n")
        f.write(f"set_clock_latency -source -max {source_latency_max} [get_clocks clk]\n")
        f.write(f"set_clock_latency -source -min {source_latency_min} [get_clocks clk]\n")
