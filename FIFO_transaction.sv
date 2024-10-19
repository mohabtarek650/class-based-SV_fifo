package FIFO_transaction_pkg ;
class FIFO_transaction;

parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
rand bit [FIFO_WIDTH-1:0] data_in;
rand bit rst_n, wr_en, rd_en;
bit [FIFO_WIDTH-1:0] data_out;
bit wr_ack, overflow;
bit full, empty, almostfull, almostempty, underflow;
bit clk;
integer RD_EN_ON_DIST , WR_EN_ON_DIST;

function void value (int rd =30 , int wr =70);
RD_EN_ON_DIST = rd;
WR_EN_ON_DIST = wr;

endfunction

constraint trans {
rst_n dist {0:=10 , 1:=90};
wr_en dist {0:=100-WR_EN_ON_DIST, 1:=WR_EN_ON_DIST};
rd_en dist {0:=100-RD_EN_ON_DIST , 1:=RD_EN_ON_DIST};
}


endclass
endpackage