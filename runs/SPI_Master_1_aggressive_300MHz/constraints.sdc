set CLK_PERIOD 3.333

######## CLOCK ########
create_clock -name clk -period $CLK_PERIOD -waveform "0 [expr $CLK_PERIOD/2]" [get_ports i_Clk]

######## CLOCK UNCERTAINTY ########
set_clock_uncertainty -setup 0.10 [get_clocks clk]
set_clock_uncertainty -hold  0.05 [get_clocks clk]

######## CLOCK SOURCE LATENCY ########
set_clock_latency -source -max 1.25 [get_clocks clk]
set_clock_latency -source -min 0.75 [get_clocks clk]
