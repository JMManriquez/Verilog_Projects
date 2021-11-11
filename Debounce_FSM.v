`timescale 1ns / 1ps

module Debounce_FSM(input wire clk, reset, btn, output reg debBtn);
//clk will be the standard 100MHz internal clock
//reset is here 
//btn = button input 
//debBtn = debounced button signal

//Symbolic State Declaration
localparam [2:0]
           zeroSignal  =  3'b000,
           wait1_10ms  =  3'b001,
           wait1_20ms  =  3'b010,
           wait1_30ms  =  3'b011,
           oneSignal   =  3'b100,
           wait0_10ms  =  3'b101,
           wait0_20ms  =  3'b110,
           wait0_30ms  =  3'b111;
           
wire Ms_Tick; //Declaring the 10 ms wait signal for our FSM
reg [2:0] state_reg, state_next; //Declaring the internal states of our FSM
           
TenMsClkGenerator FortyMsSignal(clk, reset, Ms_Tick);

//Begin FSM Logic
//State Register, only the clock controls when the state register changes
always @(posedge clk, posedge reset)
 begin
    if(reset)
       state_reg <= zeroSignal;
    else
       state_reg <= state_next;
 end 
 
 //Next-State Logic and Moore Output Logic
 always @*
  begin
     state_next = state_reg;
     case(state_reg)
         zeroSignal:
           begin
              debBtn = 1'b0;
              if(btn)
                 state_next = wait1_10ms;
           end
         wait1_10ms:
           begin
              debBtn = 1'b0;
              if(~btn)
                 state_next = zeroSignal;
              else
                 if(Ms_Tick)
                    state_next = wait1_20ms;
           end
         wait1_20ms:
           begin
              debBtn = 1'b0;
              if(~btn)
                 state_next = zeroSignal;
              else
                 if(Ms_Tick)
                    state_next = wait1_30ms;
           end
         wait1_30ms:
           begin
              debBtn = 1'b0;
              if(~btn)
                 state_next = zeroSignal;
              else
                 if(Ms_Tick)
                    state_next = oneSignal;
           end
         oneSignal:
           begin
              debBtn = 1'b1;
              if(~btn)
                 state_next = wait0_10ms;
           end
         wait0_10ms:
           begin
              debBtn = 1'b1;
              if(btn)
                 state_next = oneSignal;
              else
                 if(Ms_Tick)
                    state_next = wait0_20ms;
           end
         wait0_20ms:
           begin
              debBtn = 1'b1;
              if(btn)
                 state_next = oneSignal;
              else
                 if(Ms_Tick)
                    state_next = wait0_30ms;
           end
         wait0_30ms:
           begin
              debBtn = 1'b1;
              if(btn)
                 state_next = oneSignal;
              else
                 if(Ms_Tick)
                    state_next = zeroSignal;
           end
         default: state_next = zeroSignal;
      endcase
  end
endmodule

