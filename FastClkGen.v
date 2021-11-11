`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Fast Clock Generator, USES BASE FPGA clock and SLOWS IT to 400Hz                                                                                                                      
module FastClkGen(input clk, input resetSW, output reg outsignal);                                                                                                                       
   reg [26:0] counter; //Our Natural Clock runs at 100 MHz, we need 27 bits to count up to 100 Million                                                                                   
   //We make outsignal a register since its value will be oscillating like a clock signal                                                                                                
                                                                                                                                                                                         
   always @ (posedge clk) //At the rising edge of our natural clock                                                                                                                      
    begin                                                                                                                                                                                
       if(resetSW) //This Resets Counter and outsignal, keeping it on means no clock pulses; helps for setup                                                                             
        begin                                                                                                                                                                            
           counter = 0;                                                                                                                                                                  
           outsignal = 0;                                                                                                                                                                
        end                                                                                                                                                                              
       else                                                                                                                                                                              
        begin                                                                                                                                                                            
           counter = counter + 1;                                                                                                                                                        
           if(counter == 31_250) //This is 400Hz since the clock does 400 pulses in 1 second, since 125,0000 is counted 4 times in 100 million                                                                         
            begin                                                                                                                                                                        
               outsignal = ~outsignal; //This inverts the current value of outsignal, since it started at 0, after 1 second it becomes a 1                                               
               counter  = 0; //Reset counter inside the if condition to revert back and count up to 100M in 1s w/o needing to hit the resetSW                                            
            end                                                                                                                                                                          
        end                                                                                                                                                                              
    end                                                                                                                                                                                  
endmodule     
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
