import FIFO_transaction_pkg::*;
import FIFO_scoreboard_pkg::*;
import FIFO_coverage_pkg::*;

module fifo_tb(arb_if.TEST inter);


    // Declare scoreboard, transaction, and coverage objects
    FIFO_scoreboard score = new();
    FIFO_transaction trans = new();
    FIFO_coverage cov = new();

 
    initial begin
        initialize();
        trans.value(10,90);

      for (int i = 0; i < 10000; i++) begin
            // Randomize the transaction object
            assert(trans.randomize());

            // Drive interface signals with transaction values
             trans.clk = inter.clk;
             inter.rst_n = trans.rst_n;
             inter.wr_en = trans.wr_en;
             inter.rd_en = trans.rd_en;
             inter.data_in = trans.data_in;
            // Capture FIFO outputs into the transaction
            trans.full =  inter.full;
            trans.empty =  inter.empty;
            trans.almostfull =  inter.almostfull;
            trans.almostempty =  inter.almostempty;
            trans.underflow =  inter.underflow;
            trans.overflow =  inter.overflow;
            trans.wr_ack =  inter.wr_ack;
            trans.data_out =  inter.data_out;

            // Call the scoreboard check function
          score.check_data(trans);

            // Call the coverage sampling function
         cov.sample_data(trans);

            // Add clock cycle wait between transactions
            #10;
        end

            score.display();
     
        #100;
        $stop;
    end

    // Task to initialize the interface signals
    task initialize();
         inter.rst_n = 0;
    endtask

endmodule
