
//input ports
add mapped point i_Rst_L i_Rst_L -type PI PI
add mapped point i_Clk i_Clk -type PI PI
add mapped point i_TX_Byte[7] i_TX_Byte[7] -type PI PI
add mapped point i_TX_Byte[6] i_TX_Byte[6] -type PI PI
add mapped point i_TX_Byte[5] i_TX_Byte[5] -type PI PI
add mapped point i_TX_Byte[4] i_TX_Byte[4] -type PI PI
add mapped point i_TX_Byte[3] i_TX_Byte[3] -type PI PI
add mapped point i_TX_Byte[2] i_TX_Byte[2] -type PI PI
add mapped point i_TX_Byte[1] i_TX_Byte[1] -type PI PI
add mapped point i_TX_Byte[0] i_TX_Byte[0] -type PI PI
add mapped point i_TX_DV i_TX_DV -type PI PI
add mapped point i_SPI_MISO i_SPI_MISO -type PI PI

//output ports
add mapped point o_TX_Ready o_TX_Ready -type PO PO
add mapped point o_RX_DV o_RX_DV -type PO PO
add mapped point o_RX_Byte[7] o_RX_Byte[7] -type PO PO
add mapped point o_RX_Byte[6] o_RX_Byte[6] -type PO PO
add mapped point o_RX_Byte[5] o_RX_Byte[5] -type PO PO
add mapped point o_RX_Byte[4] o_RX_Byte[4] -type PO PO
add mapped point o_RX_Byte[3] o_RX_Byte[3] -type PO PO
add mapped point o_RX_Byte[2] o_RX_Byte[2] -type PO PO
add mapped point o_RX_Byte[1] o_RX_Byte[1] -type PO PO
add mapped point o_RX_Byte[0] o_RX_Byte[0] -type PO PO
add mapped point o_SPI_Clk o_SPI_Clk -type PO PO
add mapped point o_SPI_MOSI o_SPI_MOSI -type PO PO

//inout ports




//Sequential Pins
add mapped point o_SPI_MOSI/q o_SPI_MOSI_reg/Q -type DFF DFF
add mapped point r_TX_Bit_Count[2]/q r_TX_Bit_Count_reg[2]/Q -type DFF DFF
add mapped point o_RX_Byte[5]/q o_RX_Byte_reg[5]/Q -type DFF DFF
add mapped point o_RX_Byte[6]/q o_RX_Byte_reg[6]/Q -type DFF DFF
add mapped point o_RX_Byte[7]/q o_RX_Byte_reg[7]/Q -type DFF DFF
add mapped point o_RX_Byte[1]/q o_RX_Byte_reg[1]/Q -type DFF DFF
add mapped point o_RX_Byte[2]/q o_RX_Byte_reg[2]/Q -type DFF DFF
add mapped point r_TX_Bit_Count[1]/q r_TX_Bit_Count_reg[1]/Q -type DFF DFF
add mapped point o_RX_Byte[3]/q o_RX_Byte_reg[3]/Q -type DFF DFF
add mapped point o_RX_Byte[4]/q o_RX_Byte_reg[4]/Q -type DFF DFF
add mapped point o_RX_Byte[0]/q o_RX_Byte_reg[0]/Q -type DFF DFF
add mapped point r_TX_Bit_Count[0]/q r_TX_Bit_Count_reg[0]/Q -type DFF DFF
add mapped point o_RX_DV/q o_RX_DV_reg/Q -type DFF DFF
add mapped point r_RX_Bit_Count[1]/q r_RX_Bit_Count_reg[1]/Q -type DFF DFF
add mapped point r_RX_Bit_Count[2]/q r_RX_Bit_Count_reg[2]/Q -type DFF DFF
add mapped point r_RX_Bit_Count[0]/q r_RX_Bit_Count_reg[0]/Q -type DFF DFF
add mapped point r_SPI_Clk_Edges[4]/q r_SPI_Clk_Edges_reg[4]/Q -type DFF DFF
add mapped point r_SPI_Clk_Edges[1]/q r_SPI_Clk_Edges_reg[1]/Q -type DFF DFF
add mapped point r_SPI_Clk_Edges[3]/q r_SPI_Clk_Edges_reg[3]/Q -type DFF DFF
add mapped point r_SPI_Clk_Edges[2]/q r_SPI_Clk_Edges_reg[2]/Q -type DFF DFF
add mapped point r_SPI_Clk/q r_SPI_Clk_reg/Q -type DFF DFF
add mapped point r_SPI_Clk_Edges[0]/q r_SPI_Clk_Edges_reg[0]/Q -type DFF DFF
add mapped point r_SPI_Clk_Count[0]/q r_SPI_Clk_Count_reg[0]/Q -type DFF DFF
add mapped point r_Trailing_Edge/q r_Trailing_Edge_reg/Q -type DFF DFF
add mapped point r_Leading_Edge/q r_Leading_Edge_reg/Q -type DFF DFF
add mapped point o_TX_Ready/q o_TX_Ready_reg/Q -type DFF DFF
add mapped point r_TX_Byte[5]/q r_TX_Byte_reg[5]/Q -type DFF DFF
add mapped point r_TX_Byte[0]/q r_TX_Byte_reg[0]/Q -type DFF DFF
add mapped point r_TX_Byte[3]/q r_TX_Byte_reg[3]/Q -type DFF DFF
add mapped point r_TX_Byte[4]/q r_TX_Byte_reg[4]/Q -type DFF DFF
add mapped point r_TX_Byte[6]/q r_TX_Byte_reg[6]/Q -type DFF DFF
add mapped point r_TX_Byte[7]/q r_TX_Byte_reg[7]/Q -type DFF DFF
add mapped point r_TX_Byte[2]/q r_TX_Byte_reg[2]/Q -type DFF DFF
add mapped point r_TX_Byte[1]/q r_TX_Byte_reg[1]/Q -type DFF DFF
add mapped point o_SPI_Clk/q o_SPI_Clk_reg/Q -type DFF DFF
add mapped point r_TX_DV/q r_TX_DV_reg/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
