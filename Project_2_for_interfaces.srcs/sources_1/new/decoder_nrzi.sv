`timescale 1ns / 1ps

module decoder_nrzi(
  input clk,
  input reset,
  input logic voltage,
  input logic flag,
  
  output logic code,
  output logic error
);

logic voltage_0;

initial begin
voltage_0 = 1'b0;
end

always @(posedge clk or posedge reset) begin 
        if(reset) begin
            code = 1'b0;
            end
        else begin  
            if(voltage == voltage_0) begin
                code = 1'b0;
                voltage_0 = voltage;
//                if(flag != voltage)
//                    error = 1'b1;
//                else
//                    error = 1'b0;
            end
            else begin
                code = 1'b1;
                voltage_0 = voltage;
//                if(flag != voltage)
//                    error = 1'b1;
//                else
//                    error = 1'b0;
            end
        end
end
always @(posedge clk) begin
    if(flag != voltage)
        error = 1'b1;
    else
        error = 1'b0;
end
endmodule