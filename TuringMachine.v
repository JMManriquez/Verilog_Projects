`timescale 1ns / 1ps

module TuringMachine(input clk, ready, reset, input [7:0] tape_reg_input, output reg [7:0] tape_reg, output reg [2:0] index_reg, output reg turing_state_reg, done_reg);

localparam [1:0] turing_preparing = 2'b00, turing_operations = 2'b01, turing_halt = 2'b11;

reg [1:0] state_reg, state_reg_next;
reg [7:0] tape_reg_next;
reg [2:0] index_reg_next;
reg turing_state_reg_next, done_reg_next;

always @(posedge clk)
begin
   if(reset)
      begin
         state_reg <= turing_preparing;
         tape_reg <= tape_reg_input;
         index_reg <= 3'b111;
         turing_state_reg <= 1'b0;
         done_reg <= 1'b0;
      end
   else
      begin
         state_reg <= state_reg_next;
         tape_reg <= tape_reg_next;
         index_reg <= index_reg_next;
         turing_state_reg <= turing_state_reg_next;
         done_reg <= done_reg_next;
      end
end

always @*
begin
   tape_reg_next = tape_reg;
   index_reg_next = index_reg;
   turing_state_reg_next = turing_state_reg;
   done_reg_next = done_reg;
   
   case(state_reg)
      turing_preparing:
         begin
            tape_reg_next <= tape_reg_input;
            index_reg_next <= 3'b111;
            turing_state_reg_next <= 1'b0;
            done_reg_next <= 1'b0;
            if(ready == 1'b0)
               state_reg_next = turing_preparing;
            else
               state_reg_next = turing_operations;
         end
      turing_operations:
         begin
            if(turing_state_reg_next == 1'b1)
               state_reg_next = turing_halt;
            else
               begin
                  if((turing_state_reg_next == 1'b0)&&(tape_reg_next[index_reg_next] == 1'b0))
                     begin
                        tape_reg_next[index_reg_next] = 1'b1;
                        turing_state_reg_next = 1'b1;
                        done_reg_next = 1'b1;
                     end
                  index_reg_next = index_reg_next - 1;
                  state_reg_next = turing_operations;
               end
         end
      turing_halt:
         begin
            state_reg_next = turing_halt;
         end
      default:
         state_reg_next = turing_preparing;
   endcase
end
endmodule
