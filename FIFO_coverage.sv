package FIFO_coverage_pkg ;
import FIFO_transaction_pkg::*;
class FIFO_coverage;
FIFO_transaction F_cvg_txn = new();

    covergroup cov @(posedge F_cvg_txn.clk);
        write_enable: coverpoint F_cvg_txn.wr_en {
			bins write_enable_2 = {1};
        }
        read_enable: coverpoint F_cvg_txn.rd_en {
                        bins test_read_enable_1 = {0};

        }
		test_full: coverpoint F_cvg_txn.full {
                        bins test_full_1 = {0};

        }
		test_empty: coverpoint F_cvg_txn.empty {
                        bins test_empty_1 = {0};
	
        }
		test_almostfull: coverpoint F_cvg_txn.almostfull {
                        bins test_almostfull_1 = {0};
			
        }
		test_almostempty: coverpoint F_cvg_txn.almostempty {
                        bins test_almostempty_1 = {0};
		
        }
		test_overflow_1: coverpoint F_cvg_txn.overflow {
			bins test_overflow_1_1 = {0};
        }
		test_underflow_1: coverpoint F_cvg_txn.underflow {
			bins test_underflow_1_1 = {0};
        }
		test_wr_ack_1: coverpoint F_cvg_txn.wr_ack {
                        bins test_wr_ack_1_1 = {0};
        }
        a0: cross write_enable, test_full;
        a1: cross write_enable, test_almostfull ;
        a2: cross write_enable, test_wr_ack_1 ;
	a4: cross write_enable, test_overflow_1 ;
	b0: cross read_enable, test_empty;
	b1: cross read_enable, test_almostempty ;
	b2: cross read_enable, test_underflow_1 ;
    endgroup
    // Constructor
    function new();
        cov = new();
    endfunction 
 function void sample_data(FIFO_transaction F_txn);
      F_cvg_txn = F_txn;
      cov.sample();
    endfunction
endclass
endpackage