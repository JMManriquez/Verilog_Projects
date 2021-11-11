`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module BCDCoding(input clk, [7:0] y, output reg [7:0] BCDin);    
integer k;                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
always @(posedge clk)   
begin
   for(k = 0; k < 8; k = k + 1)
   begin                                                                                                                                                                          
         case(y[k])
         1'b0:
            BCDin = 8'b00000010; //8 Segment BCD Code for 0
         1'b1:
            BCDin = 8'b10011110; //8 Segment BCD Code for 1 
         endcase     
    end                                                                                                                                                           
end                                                                                                                                                                                                                                                                                                                                                                                                          //
endmodule