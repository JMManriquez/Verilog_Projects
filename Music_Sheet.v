`timescale 1ns / 1ps

module Music_Sheet(input [9:0] number, output reg [19:0] note, output reg [4:0] duration);
parameter EIGHTH = 5'b00001;
parameter QUARTER = 5'b00010;
parameter QUARTEREIGHTH = 5'b00011;
parameter HALF = 5'b00100;
parameter ONE = 2*HALF;
parameter TWO = 2*ONE;
parameter C4 = 95556, D4 = 85131, E4 =  75843, F4 = 71586, G4 = 63776, A4 = 56818, B5 = 50619, C5s = 45097, D5 = 42566, SP = 1;

always @(number)
begin
  case(number) //Holy, Holy, Holy
  0: begin note  = D4; duration = QUARTER; end //Ho
  1: begin note = SP; duration = EIGHTH; end //
  2: begin note  = D4; duration = QUARTER; end //ly
  3: begin note = SP; duration = EIGHTH; end //
  4: begin note  = F4; duration = QUARTER; end //Ho
  5: begin note = SP; duration = EIGHTH; end //
  6: begin note  = F4; duration = QUARTER; end //ly
  7: begin note = SP; duration = EIGHTH; end //
  8: begin note  = A4; duration = HALF; end //Ho
  9: begin note = SP; duration = QUARTER; end //
  10: begin note = A4; duration = HALF; end //ly
  11: begin note = SP; duration = QUARTER; end //
  12: begin note = B5; duration = HALF; end //Lord
  13: begin note = SP; duration = QUARTER; end //
  14: begin note = B5; duration = QUARTER; end //God
  15: begin note = SP; duration = EIGHTH; end //
  16: begin note = B5; duration = QUARTER; end //Al
  17: begin note = SP; duration = EIGHTH; end //
  18: begin note = A4; duration = HALF; end //might
  19: begin note = SP; duration = QUARTER; end //
  20: begin note = F4; duration = HALF; end //ty!
  21: begin note = SP; duration = QUARTER; end //
  
  22: begin note = A4; duration = QUARTEREIGHTH; end //Ear
  23: begin note = SP; duration = EIGHTH; end //
  24: begin note = A4; duration = EIGHTH; end //ly
  25: begin note = SP; duration = EIGHTH; end //
  26: begin note = A4; duration = QUARTER; end //in
  27: begin note = SP; duration = EIGHTH; end //
  28: begin note = A4; duration = QUARTER; end //the
  29: begin note = SP; duration = EIGHTH; end //
  30: begin note = D5; duration = HALF; end //morn
  31: begin note = SP; duration = QUARTER; end //
  32: begin note = C5s; duration = QUARTER; end //ing
  33: begin note = SP; duration = EIGHTH; end //
  34: begin note = B5; duration = QUARTER; end //our
  35: begin note = SP; duration = EIGHTH; end //
  36: begin note = D4; duration = QUARTER; end //song
  37: begin note = SP; duration = EIGHTH; end //
  38: begin note = A4; duration = QUARTER; end //shall
  39: begin note = SP; duration = EIGHTH; end //
  40: begin note = B5; duration = QUARTEREIGHTH; end //rise
  41: begin note = SP; duration = EIGHTH; end //
  42: begin note = A4; duration = EIGHTH; end //to
  43: begin note = SP; duration = EIGHTH; end //
  44: begin note = A4; duration = ONE; end //Thee
  default: begin note = C4; duration = TWO; end
  endcase
end
endmodule