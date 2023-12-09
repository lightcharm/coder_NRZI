`timescale 1ns / 1ps

module decoder_TB();

parameter PERIOD = 6;
parameter LEN = 24;

logic clk;
logic reset;
logic voltage;
logic flag;
logic code;
logic error;

logic [LEN-1:0] expected_code;
logic [LEN-1:0] tb_voltage;
logic [LEN-1:0] flag_with_errors;

decoder_nrzi dut(clk, reset, voltage, flag, code, error);

always begin
    clk = 1'b0;
    #(PERIOD/2);
    clk = 1'b1;
    #(PERIOD/2);
end

initial begin
    expected_code = 24'b0111_1101_0010_0001_0010_0000;
    tb_voltage = 24'b0101_0110_0011_1110_0011_1111;
    error = 1'b0;
    flag_with_errors = 24'b0100_0111_1011_1110_0011_1111; //подаем измененный tb_voltage[LEN-1-i] ||| сделал три ошибки
    
    for(integer i = 0; i < LEN; i++) begin
        //даем на вход:
        voltage = tb_voltage[LEN-1-i]; //со старшего разряда
        flag = flag_with_errors[LEN-1-i];
        #3;
        //проверяем результат:
        @(posedge clk) begin
            if(expected_code[LEN-1-i] == code) begin
                $display("good");
            end
            else begin
                $display("no good");
            end
        end
    end
end
endmodule
