
module FIFO_top ();

bit clk ;
initial begin
       clk = 0;
        forever begin 
            #5 clk = ~clk;
        end
    end

    arb_if inter(clk);
    fifo_tb tb(inter);    
    FIFO dut(inter);      
endmodule