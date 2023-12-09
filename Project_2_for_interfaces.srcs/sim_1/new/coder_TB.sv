`timescale 1ns / 1ps

module coder_TB();

parameter PERIOD = 6;
parameter LEN = 24; //011111010010000100100000

logic clk;
logic reset;
logic tb_binary_input;
logic [LEN-1:0] data;
logic [LEN-1:0] expected_result;

logic result_voltage;

coder_nrzi dut(.binary_input(tb_binary_input), .clk(clk), .reset(reset), .output_voltage(result_voltage));

always begin
    clk = 1'b0;
    #(PERIOD/2);
    clk = 1'b1;
    #(PERIOD/2);
end

initial begin
    data = 24'b0111_1101_0010_0001_0010_0000;
    //expected result:
    expected_result = 24'b0101_0110_0011_1110_0011_1111; //кодируем на листе
    
    for(integer i = 0; i < LEN; i++) begin
        //даем на вход:
        tb_binary_input = data[LEN-1-i]; //со старшего разряда
        #2;
        //проверяем результат:
        @(posedge clk) begin
            if(expected_result[LEN-1-i] == result_voltage) begin
                $display("good");
            end
            else begin
                $display("no good");
            end
        end
    end
end
endmodule
