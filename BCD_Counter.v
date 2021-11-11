`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module BCD_Counter(input clk, clear, setAlarm, resetAlarm, AlarmSelUp, input [3:0] SevSegSelect, output wire [7:0] AN, BCD, output wire audioOut, aud_sd,
output wire [3:0] select, output wire alarmSet1, alarmSet2, alarmReset, cleared, AlarmUp);

assign select = SevSegSelect, alarmSet1 = setAlarm, alarmSet2 = setAlarm, alarmReset = resetAlarm, cleared = clear;  //Set LED's for switches

wire selectAlarmUp,load1, load2, load3, load4, enable2, enable3, enable4, oneHz, BtnSelectHz;
reg playSound;
wire [3:0] bcd0, bcd1, bcd2, bcd3, binAOS, binATS, binAOM, binATM;
wire [7:0] BCDos, BCDts, BCDom, BCDtm, BCDaos, BCDats, BCDaom, BCDatm;

Debounce_FSM selectAlarmDebounceUp(clk, 1'b0, AlarmSelUp, selectAlarmUp); //Debounce Mechanical Button for selecting our alarm

assign AlarmUp = selectAlarmUp;

assign load1 = clear|(bcd0[0]&bcd0[3]); //Load when bcd0 counts up to 9
assign load2 = clear|(bcd1[0]&bcd1[2]&bcd0[0]&bcd0[3]); //Load when bcd1 counts up to 5 AND when bcd0 counts up to 9
assign load3 = clear|(bcd2[0]&bcd2[3]&bcd1[0]&bcd1[2]&bcd0[0]&bcd0[3]); //Load when bcd2 counts uo to 9 AND when bcd1 counts up to 5
assign load4 = clear|(bcd3[0]&bcd3[2]&bcd2[0]&bcd2[3]&bcd1[0]&bcd1[2]&bcd0[0]&bcd0[3]); //Load when bcd3 counts up to 5 AND when bcd2 counts up to 9

assign enable2 = bcd0[3]&bcd0[0]; //Enable Ten Second Counter when One Second Counter counts to 9
assign enable3 = bcd1[2]&bcd1[0]&enable2;
assign enable4 = bcd2[3]&bcd2[0]&enable3;

SlowClkGen Hz1(clk, 1'b0, 50_000_000, oneHz); //One Hz Clock for the One Second Counter

syn4Counter BCDoneSec_Counter(4'b0000, 1'b1, load1, oneHz, clear, bcd0); //Create Syncronous mod 10 One Second counter
syn4Counter BCDtenSec_Counter(4'b0000, enable2, load2, oneHz, clear, bcd1); //Create Syncronous mod 6 Ten Second counter
syn4Counter BCDoneMin_Counter(4'b0000, enable3, load3, oneHz, clear, bcd2); //Create Synchronous mod 10 ONe Minute Counter
syn4Counter BCDtenMin_Counter(4'b0000, enable4, load4, oneHz, clear, bcd3); //Create Synchronous mod 6 Ten Minute counter

SetAlarmSelector SettingAlarm(resetAlarm, selectAlarmUp, SevSegSelect, binAOS, binATS, binAOM, binATM); //Get Alarm Setting

BCDCoder oneSec7SegOutput(bcd0, 1'b0, BCDos); //Decode the binary output of the One Second Counter
BCDCoder tenSec7SegOutput(bcd1, 1'b0, BCDts); //Decode the binary output of the Ten Second Counnter
BCDCoder oneMin7SegOutput(bcd2, 1'b1, BCDom); //Decode the binary output of the One Minute Counter
BCDCoder tenMin7SegOutput(bcd3, 1'b0, BCDtm); //Decode the binary output of the Ten Minute Counter
BCDCoder alarmOneSec7SegOutput(binAOS, 1'b0, BCDaos); //Decode the Alarm's binary output of the One Second Setting
BCDCoder alarmTenSec7SegOutput(binATS, 1'b0, BCDats); //Decode the Alarm's binary output of the Ten Second Setting
BCDCoder alarmOneMin7SegOutput(binAOM, 1'b1, BCDaom); //Decode the Alarm's binary output of the One Minute Setting
BCDCoder alarmTenMin7SegOutput(binATM, 1'b0, BCDatm); //Decode the Alarm's binary output of the Ten Minute Setting

SevenSegController(clk, 2'b00, 1'b0, BCDaos, BCDats, BCDaom, BCDatm, BCDos, BCDts, BCDom, BCDtm, AN, BCD); //Persistence of Vision 7 Seg Controller along with Anode and BCD segments output

always@(posedge clk)
 begin
 if(setAlarm)
   begin
      if((BCDos==BCDaos)&&(BCDts==BCDats)&&(BCDom==BCDaom)&&(BCDtm==BCDatm))
         playSound <= 1;
   end
 else
    playSound <= 0;
end

Song_Player HolyAlarm(clk, 1'b0, playSound, audioOut, aud_sd);

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module syn4Counter(input [3:0] D, input E, L, clock, C, output reg [3:0] Q);
  always @(posedge clock)
   begin
      if(C) //If the clear is a 1, then the Q values are cleared to 0
         Q <= 0;
      else
       begin
          if(L) //If Load is engaged, you load the D value into the output Q
             Q <= D;
          else
           begin
              if(E) //If the E, enable is engaged, then you engage the counter to count up by 1
                Q <= Q + 1;
           end
       end
   end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
