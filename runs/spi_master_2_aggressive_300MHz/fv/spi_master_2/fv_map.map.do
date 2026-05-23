
//input ports
add mapped point rst_n rst_n -type PI PI
add mapped point clk clk -type PI PI
add mapped point tx_data[7] tx_data[7] -type PI PI
add mapped point tx_data[6] tx_data[6] -type PI PI
add mapped point tx_data[5] tx_data[5] -type PI PI
add mapped point tx_data[4] tx_data[4] -type PI PI
add mapped point tx_data[3] tx_data[3] -type PI PI
add mapped point tx_data[2] tx_data[2] -type PI PI
add mapped point tx_data[1] tx_data[1] -type PI PI
add mapped point tx_data[0] tx_data[0] -type PI PI
add mapped point wr_en wr_en -type PI PI
add mapped point read read -type PI PI
add mapped point mode[1] mode[1] -type PI PI
add mapped point mode[0] mode[0] -type PI PI
add mapped point baud_sel[2] baud_sel[2] -type PI PI
add mapped point baud_sel[1] baud_sel[1] -type PI PI
add mapped point baud_sel[0] baud_sel[0] -type PI PI
add mapped point spi_data_in spi_data_in -type PI PI

//output ports
add mapped point rx_data[7] rx_data[7] -type PO PO
add mapped point rx_data[6] rx_data[6] -type PO PO
add mapped point rx_data[5] rx_data[5] -type PO PO
add mapped point rx_data[4] rx_data[4] -type PO PO
add mapped point rx_data[3] rx_data[3] -type PO PO
add mapped point rx_data[2] rx_data[2] -type PO PO
add mapped point rx_data[1] rx_data[1] -type PO PO
add mapped point rx_data[0] rx_data[0] -type PO PO
add mapped point tx_not_empty tx_not_empty -type PO PO
add mapped point rx_not_empty rx_not_empty -type PO PO
add mapped point request request -type PO PO
add mapped point spi_clk spi_clk -type PO PO
add mapped point spi_data_out spi_data_out -type PO PO
add mapped point cs_n cs_n -type PO PO

//inout ports




//Sequential Pins
add mapped point brg_inst/clk_en/q brg_inst_clk_en_reg/Q -type DFF DFF
add mapped point brg_inst/cnt[5]/q brg_inst_cnt_reg[5]/Q -type DFF DFF
add mapped point trans_buf[7]/q trans_buf_reg[7]/Q -type DFF DFF
add mapped point trans_buf[4]/q trans_buf_reg[4]/Q -type DFF DFF
add mapped point trans_buf[5]/q trans_buf_reg[5]/Q -type DFF DFF
add mapped point brg_inst/cnt[4]/q brg_inst_cnt_reg[4]/Q -type DFF DFF
add mapped point trans_buf[2]/q trans_buf_reg[2]/Q -type DFF DFF
add mapped point trans_buf[0]/q trans_buf_reg[0]/Q -type DFF DFF
add mapped point trans_buf[6]/q trans_buf_reg[6]/Q -type DFF DFF
add mapped point trans_buf[1]/q trans_buf_reg[1]/Q -type DFF DFF
add mapped point trans_buf[3]/q trans_buf_reg[3]/Q -type DFF DFF
add mapped point state[0]/q state_reg[0]/Q -type DFF DFF
add mapped point bit_cnt[2]/q bit_cnt_reg[2]/Q -type DFF DFF
add mapped point state[1]/q state_reg[1]/Q -type DFF DFF
add mapped point bit_cnt[1]/q bit_cnt_reg[1]/Q -type DFF DFF
add mapped point bit_cnt[0]/q bit_cnt_reg[0]/Q -type DFF DFF
add mapped point brg_inst/cnt[3]/q brg_inst_cnt_reg[3]/Q -type DFF DFF
add mapped point txne/q txne_reg/Q -type DFF DFF
add mapped point brg_inst/ref_cpha_0/q brg_inst_ref_cpha_0_reg/Q -type DFF DFF
add mapped point state[2]/q state_reg[2]/Q -type DFF DFF
add mapped point state[3]/q state_reg[3]/Q -type DFF DFF
add mapped point busy/q busy_reg/Q -type DFF DFF
add mapped point rx_buf[3]/q rx_buf_reg[3]/Q -type DFF DFF
add mapped point rx_buf[1]/q rx_buf_reg[1]/Q -type DFF DFF
add mapped point rx_buf[0]/q rx_buf_reg[0]/Q -type DFF DFF
add mapped point rx_buf[2]/q rx_buf_reg[2]/Q -type DFF DFF
add mapped point rxne/q rxne_reg/Q -type DFF DFF
add mapped point done/q done_reg/Q -type DFF DFF
add mapped point rx_buf[4]/q rx_buf_reg[4]/Q -type DFF DFF
add mapped point rx_buf[5]/q rx_buf_reg[5]/Q -type DFF DFF
add mapped point rx_buf[7]/q rx_buf_reg[7]/Q -type DFF DFF
add mapped point rx_buf[6]/q rx_buf_reg[6]/Q -type DFF DFF
add mapped point brg_inst/cnt[2]/q brg_inst_cnt_reg[2]/Q -type DFF DFF
add mapped point brg_inst/cnt[1]/q brg_inst_cnt_reg[1]/Q -type DFF DFF
add mapped point brg_inst/cnt[0]/q brg_inst_cnt_reg[0]/Q -type DFF DFF
add mapped point tx_buf[6]/q tx_buf_reg[6]/Q -type DFF DFF
add mapped point tx_buf[5]/q tx_buf_reg[5]/Q -type DFF DFF
add mapped point tx_buf[3]/q tx_buf_reg[3]/Q -type DFF DFF
add mapped point tx_buf[1]/q tx_buf_reg[1]/Q -type DFF DFF
add mapped point tx_buf[0]/q tx_buf_reg[0]/Q -type DFF DFF
add mapped point tx_buf[2]/q tx_buf_reg[2]/Q -type DFF DFF
add mapped point brg_inst/ref_cpha_1/q brg_inst_ref_cpha_1_reg/Q -type DFF DFF
add mapped point tx_buf[4]/q tx_buf_reg[4]/Q -type DFF DFF
add mapped point tx_buf[7]/q tx_buf_reg[7]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
