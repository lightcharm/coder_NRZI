`timescale 1ns / 1ps

module multiplexing(
    input binary_input,
    input clk,
    input reset,
    input clk_big,
    output logic out_common
    );

//logic [5:0] counter_clk;
logic counter_clk;

logic out_1var;
logic out_2var;

initial begin
    counter_clk = 1'b0;
    out_common = 1'bx;
end
//подключим два кодера (первый и второй варианты)
coder_nrzi coder_1var(
    .binary_input(binary_input),
    .clk(clk),
    .reset(reset),
    .output_voltage(out_1var),
    .saved_value_voltage(saved_value_voltage)
);

coder_nrzi_2var coder_2var(
    .binary_input(binary_input),
    .clk(clk),
    .reset(reset),
    .output_voltage(out_2var),
    .saved_value_voltage(saved_value_voltage_2var)
);

always @(posedge clk_big) begin //должен записывать в !два раза чаще, чем работают кодеры
    if(counter_clk == 0) begin    //~^counter_clk == 1
        out_common = out_1var;
        //counter_clk = counter_clk + 1;
        counter_clk = 1'b1;
        $display($time, "out_common = %b, binnary = %b, out_1var = %b, out_2var = %b", out_common, binary_input, out_1var, out_2var);
    end
    else if(counter_clk == 1) begin
        out_common = out_2var;
        //counter_clk = counter_clk + 1;
        counter_clk = 1'b0;
        $display($time, "out_common = %b, binnary = %b, out_1var = %b, out_2var = %b", out_common, binary_input, out_1var, out_2var);
    end
    else
        $display("ERROR");
end
endmodule
