`timescale 1ns / 1ps


module SetAlarmSelector(input clearAlarm, AlarmSelUp, input [3:0] SevSegSelect, output reg [3:0] binAOS, binATS, binAOM, binATM);
//clk at 100MHz, 3 Bit SevSegSelect to choose and select which of the left 7 segment we are selecting
//4 Bit alarm select to select a decimal number from 0 to 9 for the specific 7 segment display that is chosen
//4 Bit Binary Output of the Selected Number for each Alarm's 7 Segment
always @(posedge AlarmSelUp)
begin
   if((SevSegSelect == 4'b0001)&~clearAlarm)
    begin
         if(binAOS == 4'b1001)
            binAOS <= 4'b0000;
         else
            binAOS <= binAOS + 1; //Store the Binary Number of the Alarm selectedin a register
    end
   else if((SevSegSelect == 4'b0010)&~clearAlarm)
    begin
         if(binATS == 4'b0101)
            binATS <= 4'b0000;
         else
            binATS <= binATS + 1; //Store the Binary Number of the Alarm selectedin a register
    end
   else if((SevSegSelect == 4'b0100)&~clearAlarm)
    begin
         if(binAOM == 4'b1001)
            binAOM <= 4'b0000;
         else
            binAOM <= binAOM + 1; //Store the Binary Number of the Alarm selected in a register
    end
   else if((SevSegSelect == 4'b1000)&~clearAlarm)
    begin
         if(binATM == 4'b0101)
            binATM <= 4'b0000;
         else
            binATM <= binATM + 1; //Store the Binary Number of the Alarm selected in a register
    end
   else if(clearAlarm)
    begin
        binAOS <= 4'b0000;
        binATS <= 4'b0000;
        binAOM <= 4'b0000;
        binATM <= 4'b0000;
    end
    else
     begin
        binAOS <= binAOS;
        binATS <= binATS;
        binAOM <= binAOM;
        binATM <= binATM;
     end
end
endmodule
