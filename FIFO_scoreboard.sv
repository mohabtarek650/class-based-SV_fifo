package FIFO_scoreboard_pkg;

  import FIFO_transaction_pkg::*;

  class FIFO_scoreboard;

    bit [15:0] data_out_ref;
    bit full_ref, empty_ref, almostfull_ref, almostempty_ref, wr_ack_ref, overflow_ref, underflow_ref,count_ref;
    int error_count = 0;
    int correct_count = 0;

 function void counter(FIFO_transaction F_txn);
 if( ({F_txn.wr_en, F_txn.rd_en} == 2'b10) && !F_txn.full) begin
	count_ref = count_ref + 1;
        wr_ack_ref = 1;
   end else if ( ({F_txn.wr_en, F_txn.rd_en} == 2'b01) && !F_txn.empty) begin
	count_ref = count_ref - 1;
    end
      endfunction

    function void reference_model(FIFO_transaction F_txn);
      counter(F_txn);
      wr_ack_ref =(F_txn.wr_en && !F_txn.full);
      full_ref = (count_ref == F_txn.FIFO_DEPTH);
      empty_ref = (count_ref == 0);
      almostfull_ref = (count_ref == F_txn.FIFO_DEPTH - 2);
      almostempty_ref = (count_ref == 1);
      overflow_ref = ( F_txn.full && F_txn.wr_en );
      underflow_ref = (F_txn.empty && F_txn.rd_en );
    endfunction

    function void check_data(FIFO_transaction F_txn);
     
      reference_model(F_txn);

      if (F_txn.wr_ack == wr_ack_ref &&
          F_txn.full == full_ref &&
          F_txn.empty == empty_ref &&
          F_txn.almostfull == almostfull_ref &&
          F_txn.almostempty == almostempty_ref &&
          F_txn.overflow == overflow_ref &&
          F_txn.underflow == underflow_ref) begin
        correct_count++;
        $display("Pass:full=%d,ref=%d,empty=%d,ref=%d,overflow=%d,ref=%d,underflow=%d,ref=%d",F_txn.full,full_ref,F_txn.empty,empty_ref,F_txn.overflow,overflow_ref,F_txn.underflow,underflow_ref);

      end else begin
        error_count++;
        $display("Error: Mismatch ,data_out=%d,ref=%d,full=%d,ref=%d,empty=%d,ref=%d,overflow=%d,ref=%d,underflow=%d,ref=%d,almostfull=%d,ref=%d,almostempty=%d,ref=%d",F_txn.data_out,data_out_ref,F_txn.full,full_ref,F_txn.empty,empty_ref,F_txn.overflow,overflow_ref,F_txn.underflow,underflow_ref,F_txn.almostfull,almostfull_ref,F_txn.almostempty,almostempty_ref);
      end
    endfunction
     function void display();
         $display("Error=%d,correct=%d" ,error_count,correct_count);
      endfunction
endclass
endpackage