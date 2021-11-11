`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module SevenSegController(input Clock, Load, resetSW, input [7:0] y, output reg [7:0] AN, BCD);
wire sixteenHundredHz;
wire [2:0] select;
wire [7:0] BCDselect;
integer k;

FastClkGen Hz1600(Clock, resetSW, sixteenHundredHz);
upCounter3Bit Rapid3BitCounter(sixteenHundredHz, Load, 3'b000, select); //Need 3 Bit counter
Decoder3to8 Rapid7SegSelector(select, BCDselect); //Need a 3 to 8 Decoder

always@(select)
 begin
    for(k = 0; k < 8; k = k + 1)
    begin   
       AN = ~BCDselect; //Here we invert BCDselect so that only 1 segment is enabled at a time. This is output to our constraint file for the anode being chosen                                                                                                                                                                       
       case(y[k])
          1'b0:
             BCD <= 8'b00000011; //8 Segment BCD Code for 0
          1'b1:
             BCD <= 8'b10011111; //8 Segment BCD Code for 1 
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