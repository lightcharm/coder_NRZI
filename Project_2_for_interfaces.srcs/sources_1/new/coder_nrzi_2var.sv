`timescale 1ns / 1ps

module coder_nrzi_2var(
    input binary_input,
    input clk,
    input reset,
    //_
    output logic output_voltage,
    output logic saved_value_voltage
    );
    
initial begin
    output_voltage = 1'b0; //из-за этого необходимо 24 разряда в ТБ
    saved_value_voltage = output_voltage;
end

always @(posedge clk or posedge reset) begin
     if(reset) begin
        output_voltage = 1'b0;
        saved_value_voltage = output_voltage;
     end
     else begin
        if(binary_input == 1) begin
            output_voltage = saved_value_voltage;
            saved_value_voltage = output_voltage;
        end
        else begin
            output_voltage = ~saved_value_voltage;
            saved_value_voltage = output_voltage;
        end
     end
end
endmodule
