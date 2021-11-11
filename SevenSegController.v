`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module SevenSegController(input Clock, Load, resetSW, input [7:0] BCDaos, BCDats, BCDaom, BCDatm, BCDos, BCDts, BCDom, BCDtm, output reg [7:0] AN, BCD);
wire sixteenHundredHz;
wire [2:0] select;
wire [7:0] BCDselect;

FastClkGen Hz1600(Clock, resetSW, sixteenHundredHz);
upCounter3Bit Rapid3BitCounter(sixteenHundredHz, Load, 3'b000, select); //Need 3 Bit counter
Decoder3to8 Rapid7SegSelector(select, BCDselect); //Need a 3 to 8 Decoder

always@(select)
 begin
    AN = ~BCDselect; //Here we invert BCDselect so that only 1 segment is enabled at a time. This is output to our constraint file for the anode being chosen
      begin
         case(select) //400 times per second this case switch is engaged
            3'b000: //Decimal 0                                                                                                      
               BCD <= BCDos; //Here we output the onesSecond BCD output into the rightmost BCD segment when it is selected                                                                                                                                      
            3'b001: //Decimal 1                                                                                                                                                         
               BCD <= BCDts; //Here we output the tensSecond BCD output into the next BCD segment when it is selected                                                                                                                                   
            3'b010: //Decimal 2                                                                                                                                                         
               BCD <= BCDom; //Here we output the onesMinute BCD output into the next BCD segment when it is selected                                                                                                                                
            3'b011: //Decimal 3                                                                                                                                                         
               BCD <= BCDtm; //Here we output the tensMinute BCD output into the leftmost BCD segment when it is selected
            3'b100: //Decimal 4                                                                                                                                                         
               BCD <= BCDaos; //Here we output the Alarm's onesSecond BCD output into the leftmost BCD segment when it is selected
            3'b101: //Decimal 5                                                                                                                                                         
               BCD <= BCDats; //Here we output the Alarm's tensSecond BCD output into the leftmost BCD segment when it is selected
            3'b110: //Decimal 6                                                                                                                                                      
               BCD <= BCDaom; //Here we output the Alarm's onesMinute BCD output into the leftmost BCD segment when it is selected
            3'b111: //Decimal 7                                                                                                                                                         
               BCD <= BCDatm; //Here we output the Alarm's tensMinute BCD output into the leftmost BCD segment when it is selected 
            default:
               BCD <= 8'b00000011; //If the previous is not selected, or if we go into a default case we display 0
         endcase
      end
 end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//2 Bit Up Counter with Reset, Load option w/ load of D bits, Clock  Signal Input which will come from SlowClkGen module, and output Q in binary which will be handed to SevenSeg module          
module upCounter3Bit(input Clock, Load, input [2:0] D, output reg [2:0] Q);  //Since Enable is always 1, we remove it                                                                        
   always@(posedge Clock)
     begin                                                                                                                                               
      if(Load) //We need to flip the switch from on to off to on in the same sequence to prevent Q staying at 0 //Keeping it from on to off only keeps Q at 0                         
         Q <= D; //Non blockig which is done in parallel                                                                                                                                 
      else                                                                 
         Q = Q + 1;
     end                                                                                                                                                                    
endmodule

module Decoder3to8(input [3:0] data, output reg [7:0] y);
    always @(data)
    begin
        y = 0;
        y[data] = 1;
    end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////