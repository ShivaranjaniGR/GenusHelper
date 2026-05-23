module spi_master#(parameter SLAVE_COUNT = 8)(
  input clk,
  input rst,
  input ext_spi_clkx2, //Double the spi freq.
  input start_trans, //Start transaction
  output busy, 
  output reg MOSI, 
  input MISO, 
  output SCLK, 
  output reg [(SLAVE_COUNT-1):0] CS, 
  input [31:0] tx_data, 
  output reg [31:0] rx_data, 
  input [($clog2(SLAVE_COUNT)-1):0] chipADDRS, 
  input [1:0] transaction_length, //0b00 8bit, 0b01 16bit, 0b10 24bit, 0b11 32bit
  input CPOL, //Clock polarity
  input CPHA, //Clock phase
  input default_val);
  //Slave address width
  localparam SLAVE_ADDRS_LEN = $clog2(SLAVE_COUNT);
  //SPI state related signals
  localparam SPI_READY  = 2'b00, //Ready for new process
            SPI_PRE_Tx  = 2'b01, //Pre transfer process
            SPI_Tx  = 2'b11, //SPI transfer in progress
            SPI_POST_Tx = 2'b10; //Post transfer process
  reg [4:0] SPI_transaction_counter;
  reg [1:0] SPI_state;
  wire SPI_ready, SPI_pre_t, SPI_working, SPI_post_t;
  //Buffers
  reg [31:0] rx_buff;
  reg [32:0] tx_buff;
  //Counters and clocking
  reg spi_clk_main; //Main SPI clock 
  wire spi_clk_sys; //SPI clock to be used in the module

  //Decode states
  assign SPI_ready = (SPI_state == SPI_READY);
  assign SPI_pre_t = (SPI_state == SPI_PRE_Tx);
  assign SPI_working = (SPI_state == SPI_Tx);
  assign SPI_post_t = (SPI_state == SPI_POST_Tx);
  assign busy = ~SPI_ready;

  //Generated clock
  always@(posedge ext_spi_clkx2 or posedge rst)
    begin
      if(rst) begin
        spi_clk_main <= 1'b0;
      end else begin
        spi_clk_main <= ~spi_clk_main;
      end
    end
  //SPI clock should not work when not in use
  assign SCLK = (SPI_working) ? (CPOL ^ spi_clk_main) : CPOL;
  //Clock polarisation and phase adjustment for inner logic
  assign spi_clk_sys = (SCLK ^ CPOL) ^ CPHA;

  //SPI states
  always@(posedge clk)
    begin
      if(rst)
        begin
          SPI_state <= SPI_READY;
        end
      else
        begin
          case(SPI_state)
            SPI_READY:
              begin
                SPI_state <= (start_trans) ? SPI_PRE_Tx : SPI_READY;
              end
            SPI_PRE_Tx:
              begin
                SPI_state <= (CPOL == (spi_clk_main ^ CPOL)) ? SPI_Tx : SPI_PRE_Tx;
              end
            SPI_Tx:
              begin
                SPI_state <= (((~|SPI_transaction_counter & ext_spi_clkx2) & (CPOL == SCLK))) ? SPI_POST_Tx : SPI_Tx;
              end
            SPI_POST_Tx:
              begin
                SPI_state <= SPI_READY;
              end
          endcase
        end
    end

  //SPI transaction counter
  always@(negedge ext_spi_clkx2 or posedge SPI_pre_t)
    begin
      if(SPI_pre_t)
        begin
          case(transaction_length)
            2'b00: //8bit
              begin
                SPI_transaction_counter <= 5'd24;
              end
            2'b01: //16bit
              begin
                SPI_transaction_counter <= 5'd16;
              end
            2'b10: //24bit
              begin
                SPI_transaction_counter <= 5'd8;
              end
            2'b11: //32bit
              begin
                SPI_transaction_counter <= 5'd0;
              end
          endcase
        end
      else
        begin
          SPI_transaction_counter <= SPI_transaction_counter + {4'h0,(spi_clk_main & SPI_working)};
        end
    end

  //MOSI handle according to Tx leght
  always@*
    begin
      if(busy)
        case(transaction_length)
          2'd0:
            begin
              MOSI = (CPHA) ? tx_buff[8] : tx_buff[7];
            end
          2'd1:
            begin
              MOSI = (CPHA) ? tx_buff[16] : tx_buff[15];
            end
          2'd2:
            begin
              MOSI = (CPHA) ? tx_buff[24] : tx_buff[23];
            end
          2'd3:
            begin
              MOSI = (CPHA) ? tx_buff[32] : tx_buff[31];
            end 
        endcase
      else
        MOSI = default_val;
    end
  
  //Transmit buffer
  always@(negedge spi_clk_sys or posedge SPI_pre_t)
    begin
      if(SPI_pre_t)
        begin
          tx_buff <= {default_val, tx_data};
        end
      else
        begin
          tx_buff <= {tx_buff[31:0], default_val};
        end
    end
  
  //Receive buffer
  always@(posedge spi_clk_sys or posedge SPI_ready)
    begin
      if(SPI_ready)
        begin
          rx_buff <= 32'h0;
        end
      else
        begin
          rx_buff <= {rx_buff[30:0], MISO};
        end
    end
  
  //Store receive buffer data to rx_data
  always@(posedge clk)
    begin  
      rx_data <= (SPI_post_t) ? rx_buff : rx_data;
    end

  //Chip (Slave) select
  always@(posedge clk)
    begin
      if(rst)
        begin
          CS <= {SLAVE_COUNT{1'b1}};
        end
      else
        begin
          case(SPI_state)
            SPI_READY:
              begin
                CS[chipADDRS] <= ~start_trans;
              end
            SPI_POST_Tx:
              begin
                CS <= {SLAVE_COUNT{1'b1}};
              end
          endcase
        end
    end
endmodule

