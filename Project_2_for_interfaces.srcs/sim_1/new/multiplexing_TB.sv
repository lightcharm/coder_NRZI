`timescale 1ns / 1ps

module multiplexing_TB();

parameter PERIOD = 8;
parameter PERIOD_big = 4;
parameter LEN = 23;

logic clk;
logic clk_big;
logic reset;
logic tb_binary_input;

logic [LEN-1:0] data;
logic [46-1:0] expected_result;
logic out_common_temp;

logic crutch;
initial begin
    crutch = 1'b0;
    #3;
    crutch = 1'b1;
end

multiplexing dut(
    .binary_input(tb_binary_input),
    .clk(clk),
    .reset(reset),
    .clk_big(clk_big),
    .out_common(out_common_temp)
);

always begin
    clk = 1'b0;
    #(PERIOD/2);
    clk = 1'b1;
    #(PERIOD/2);
end

//initial begin
//    clk_big = 1'b0;
//    #(PERIOD_big/2);
//end

always begin
    if (crutch == 0) begin
        clk_big = 1'b0;
        #(PERIOD_big/2);
    end
    else begin
        clk_big = 1'b0;
        #(PERIOD_big/2);
        clk_big = 1'b1;
        #(PERIOD_big/2);
    end
end

//ДЕмультиплексирование
//logic [LEN-1:0] out_res_1;
//logic [LEN-1:0] out_res_2;
logic clk_temp = 1'b0;
logic [46-1:0] in_common;
//initial begin
//    in_common = expected_result;
//    $display("in_common = %b", in_common);
//end

initial begin
    data = 23'b111_1101_0010_0001_0010_0000;
    expected_result = 46'b10_0010_0010_1101_0001_1110_1110_1101_0001_1110_1110_1110; //кодируем на листе
    in_common = expected_result;
    $display("in_common = %b", in_common);
    //@(posedge clk) begin
        for(integer i = 0; i < 23; i++) begin
            //даем на вход:
            tb_binary_input = data[LEN-1-i]; //со старшего разряда
            #8;
            
//            //проверяем результат:
//            @(posedge clk_big) begin
//                if(expected_result[46-1-i] == out_common_temp) begin
//                    $display("good");
//                end
//                else begin
//                    $display("no good");
//                end
//            end
        end
        #4;
        $finish;
//    @(posedge clk_big)
//    for(integer i = 23-1; i>=0; i--) begin
//            @(posedge clk_big)
//                    out_res_1[i] = out_common_temp;
//                    $display("out_res_1 = %b, out_res_2 = %b", out_res_1, out_res_2);
//            @(posedge clk_big)
//                    out_res_2[i] = out_common_temp;
//                    $display("out_res_1 = %b, out_res_2 = %b", out_res_1, out_res_2);
//    end
//    $display("out_res_1 = %b, out_res_2 = %b", out_res_1, out_res_2);
//    //end
end

////ДЕмультиплексирование
//logic [LEN-1:0] out_res_1;
//logic [LEN-1:0] out_res_2;
//logic clk_temp = 1'b0;
//logic [46-1:0] in_common;
//initial begin
//    in_common = expected_result;
//    $display("in_common = %b", in_common);
//end

//initial begin
//    #186;
//    for(integer j = 46-1; j>=0; j--) begin
//        for(integer i = 23-1; i>=0; i--) begin
//            @(posedge clk_big) begin //должен записывать в !два раза чаще, чем работают кодеры
//                if(clk_temp == 0) begin    //~^counter_clk == 1
//                    out_res_1[i] = in_common[j];
//                    clk_temp = 1'b1;
//                    //$display($time, "in_common = %b, binnary = %b, out_1var = %b, out_2var = %b", in_common, binary_input, out_1var, out_2var);
//                end
//                else if(clk_temp == 1) begin
//                    out_res_2[i] = in_common[j-1];
//                    clk_temp = 1'b0;
//                    //$display($time, "in_common = %b, binnary = %b, out_1var = %b, out_2var = %b", in_common, binary_input, out_1var, out_2var);
//                end
//                else
//                    $display("ERROR");
//            end
//        end
//    end
//    $display("out_res_1 = %b, out_res_2 = %b", out_res_1, out_res_2);
//end

endmodule