`timescale 1ns / 1ps


module TuringMachineImplementation(input clock, clockButton, ready, reset, input [7:0] tape_reg_input, output wire [7:0] tape, output wire [2:0] index, output wire turing_state, done);
wire clk;

Debounce_FSM bttnClock(clock, 1'b0, clockButton, clk);

TuringMachine theTuring(clk, ready, reset, tape_reg_input, tape, index, turing_state, done);

endmodule
