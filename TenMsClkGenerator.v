`timescale 1ns / 1ps

module TenMsClkGenerator(input clk, input resetSW, output reg outSignal);
   reg [26:0] counter; //Our Natural Clock runs at 100 MHz, we need 27 bits to count up to 100 Million                                                                                   
   //We make outsignal a register since its value will be oscillating like a clock signal                                                                                                
                                                                                                                                                                                         
   always @ (posedge clk) //At the rising edge of our natural clock                                                                                                                      
    begin                                                                                                                                                                                
       if(resetSW) //This Resets Counter and outsignal, keeping it on means no clock pulses; helps for setup                                                                             
        begin                                                                                                                                                                            
           counter = 0;                                                                                                                                                                  
           outSignal = 0;                                                                                                                                                                
        end                                                                                                                                                                              
       else                                                                                                                                                                              
        begin                                                                                                                                                                            
           counter = counter + 1;                                                                                                                                                        
           if(counter == 2_000_000)                                                                   
            begin                                                                                                                                                                        
               outSignal = ~outSignal; //This inverts the current value of outsignal, since it started at 0, after 1 second it becomes a 1                                               
               counter  = 0; //Reset counter inside the if condition to revert back and count up to 100M in 1s w/o needing to hit the resetSW                                            
            end                                                                                                                                                                          
        end                                                                                                                                                                              
    end
endmodule