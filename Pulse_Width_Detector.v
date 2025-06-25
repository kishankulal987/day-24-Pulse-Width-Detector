`timescale 1ns / 1ps

module pulse_width_detector #(
    parameter THRESHOLD = 1
)(
    input clk,
    input reset,
    input pulse_in,        
    output reg pulse_out,
    output reg [15:0]pulse_width  
);

    reg [15:0] count;
    reg prev_in;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            pulse_out <= 0;
            prev_in<=0;
        end else begin
        prev_in<=pulse_in;
            if (pulse_in) begin
                count <= count + 1;
                    if (count > 1) begin
                        pulse_out <= 1;
                    end
                end
            end
        if(prev_in && !pulse_in) begin
        pulse_width<=count;
        count<=0;
        end
        end
endmodule



module testbench;
reg clk,reset,pulse_in;
wire [15:0]pulse_width;
wire pulse_out;
pulse_width_detector m1(clk,reset,pulse_in,pulse_out,pulse_width);
initial clk=0;
always #5 clk=~clk;
initial begin
reset=1;
pulse_in=0;
#5 reset=0;pulse_in=1;
#50;
pulse_in=0;
#200;
$finish;
end
endmodule
