`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module BCDCoder(input [3:0] y, input dp, output reg [7:0] BCD);                                                                                                           
 //Declare the binary 4 bit width input y                                                                                                                                                
 //Declare the decoded 8 bit width BCD code                                                                                                                                                                                                                                                                                                                                                                 
 always @(y)                                                                                                                                                                             
  begin
   if(dp)
    begin
    case(y)                                                                                                                                                                              
        4'b0000: //Decimal 0, this follows the decoder Output from Prev. module                                                                                                      
            BCD = 8'b00000010; //8 Segment BCD Code for 0                                                                                                                                  
        4'b0001: //Decimal 1                                                                                                                                                         
            BCD = 8'b10011110; //8 Segment BCD Code for 1                                                                                                                                  
        4'b0010: //Decimal 2                                                                                                                                                         
            BCD = 8'b00100100; //8 Segment BCD Code for 2                                                                                                                                  
        4'b0011: //Decimal 3                                                                                                                                                         
            BCD = 8'b00001100; //8 Segment BCD Code for 3                                                                                                                                  
        4'b0100: //Decimal 4                                                                                                                                                         
            BCD = 8'b10011000; //8 Segment BCD Code for 4                                                                                                                                  
        4'b0101: //Decimal 5                                                                                                                                                                                                                                                                                                              
            BCD = 8'b01001000; //8 Segment BCD Code for 5                                                                                                                                  
        4'b0110: //Decimal 6                                                                                                                                                         
            BCD = 8'b01000000; //8 Segment BCD Code for 6                                                                                                                                  
        4'b0111: //Decimal 7                                                                                                                                                         
            BCD = 8'b00011110; //8 Segment BCD Code for 7
        4'b1000: //Decimal 8
            BCD = 8'b00000000; //8 Segment BCD Code for 8
        4'b1001: //Decimal 9
            BCD = 8'b00001000; //8 Segment BCD Code for 9                                                                                                                                  
        default: //Default case, must always include for Switch Statement                                                                                                                
            BCD = 8'b00000000; //We will set BCD Code for 8 as our default                                                                                                                 
    endcase
    end
   else
    begin                                                                                                                                                                                  
        case(y)                                                                                                                                                                              
            4'b0000: //Decimal 0, this follows the decoder Output from Prev. module                                                                                                      
                BCD = 8'b00000011; //8 Segment BCD Code for 0                                                                                                                                  
            4'b0001: //Decimal 1                                                                                                                                                         
                BCD = 8'b10011111; //8 Segment BCD Code for 1                                                                                                                                  
            4'b0010: //Decimal 2                                                                                                                                                         
                BCD = 8'b00100101; //8 Segment BCD Code for 2                                                                                                                                  
            4'b0011: //Decimal 3                                                                                                                                                         
                BCD = 8'b00001101; //8 Segment BCD Code for 3                                                                                                                                  
            4'b0100: //Decimal 4                                                                                                                                                         
                BCD = 8'b10011001; //8 Segment BCD Code for 4                                                                                                                                  
            4'b0101: //Decimal 5                                                                                                                                                                                                                                                                                                              
                BCD = 8'b01001001; //8 Segment BCD Code for 5                                                                                                                                  
            4'b0110: //Decimal 6                                                                                                                                                         
                BCD = 8'b01000001; //8 Segment BCD Code for 6                                                                                                                                  
            4'b0111: //Decimal 7                                                                                                                                                         
                BCD = 8'b00011111; //8 Segment BCD Code for 7
            4'b1000: //Decimal 8
                BCD = 8'b00000001; //8 Segment BCD Code for 8
            4'b1001: //Decimal 9
                BCD = 8'b00001001; //8 Segment BCD Code for 9                                                                                                                                  
            default: //Default case, must always include for Switch Statement                                                                                                                
                BCD = 8'b00000001; //We will set BCD Code for 8 as our default                                                                                                                 
        endcase
    end                                                                                                                                                                              
  end                                                                                                                                                                                                                                                                                                                                                                                                          //
endmodule   