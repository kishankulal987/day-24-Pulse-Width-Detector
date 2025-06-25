# Pulse Width Detector in Verilog

# Overview

In this project, I implemented a pulse width detector in Verilog using sequential logic. My goal was to create a circuit that measures the duration of a high pulse on the input signal pulse_in in terms of clock cycles and outputs the width in a 16-bit register, while also generating an output pulse pulse_out when the width exceeds a parameterized threshold (default: 1 cycle). For example, with a 10ns clock period, if pulse_in is high for 50ns, the circuit outputs pulse_width=5 and sets pulse_out=1 after the second cycle. I used a counter and edge detection to measure the pulse width and wrote a testbench to verify the functionality with a specific input pulse. I confirmed the design works as expected through simulation.

Module: pulse_width_detector





What I Did: I designed a circuit to measure the duration of a high pulse and generate an output signal based on a threshold.



Parameters:





THRESHOLD: Minimum pulse width in clock cycles to assert pulse_out (default: 1).



Inputs:





clk: Clock signal.



reset: Asynchronous reset signal.



pulse_in: Input pulse signal to measure.



Outputs:





pulse_out: Output signal, high when pulse width exceeds THRESHOLD.



pulse_width[15:0]: 16-bit register storing the measured pulse width in clock cycles.



How It Works:





I used a 16-bit counter (count) to track the number of clock cycles pulse_in is high.



A register prev_in stores the previous value of pulse_in to detect falling edges.



On positive clock edge or reset:





If reset=1, count, pulse_out, and prev_in are cleared to 0.



If pulse_in=1, count increments, and pulse_out is set to 1 if count > 1 (exceeding THRESHOLD=1).



On a falling edge (prev_in=1 and pulse_in=0), pulse_width is set to count, and count is reset to 0.



For example, with pulse_in high for 5 clock cycles:





count increments from 0 to 5.



pulse_out goes high after the second cycle (count > 1).



On falling edge, pulse_width=5, and count resets.



Style: Behavioral modeling with sequential logic.

Testbench: testbench





What I Did: I created a testbench to verify the pulse width detector’s functionality.



How It Works:





I generated a clock with a 10ns period (#5 clk = ~clk).



I tested one scenario:





reset=1 initially, then reset=0 after 5ns.



pulse_in=1 for 50ns (5 clock cycles), then pulse_in=0.



Simulation runs for 255ns, ending with $finish.



I used $monitor to display time, reset, pulse_in, pulse_out, pulse_width, and count whenever they change.



Time Scale: I set 1ns / 1ps for precise simulation timing.



Purpose: My testbench ensures the circuit correctly measures the pulse width and asserts pulse_out when the width exceeds the threshold.

Files





pulse_width_detector.v: Verilog module for the pulse width detector.



testbench.v: Testbench for simulation.



## Simulation Waveform

Below is the simulation waveform, showing inputs clk, reset, pulse_in, and outputs pulse_out, pulse_width[15:0], along with internal count.



<img width="764" alt="image" src="https://github.com/user-attachments/assets/60d74851-1801-4eac-a7a4-3e81a4aa8e4f" />
