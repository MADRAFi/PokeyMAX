unit pm_config;
(*
* @type: unit
* @author: MADRAFi <madrafi@gmail.com>
* @name: PokeyMAX config library.
* @version: 0.0.1

* @description:
* Set of useful constants, and structures to work with ATARI PokeyMAX. 
*
*)

interface

uses pm_detect;


const
    // Address references
    CONFIG_PSGMODE = $5;
    CONFIG_SIDMODE = $6;
 
    // Masks
    CONFIG_PSGMODE_FREQ = $3;
    CONFIG_PSGMODE_STEREO = $c;
    CONFIG_PSGMODE_ENVELOPE = $10;
    CONFIG_PSGMODE_VOLUME = $60;
    
    CONFIG_SIDMODE_SID1TYPE = $1;
    CONFIG_SIDMODE_SID1DIGI = $2;
    CONFIG_SIDMODE_SID2TYPE = $10;
    CONFIG_SIDMODE_SID2DIGI = $20;

type
    // Window handle info
    TPMAX_CONFIG = record
        mode_option: Byte;      // 1 = Quad             2 = Stereo          3 = Mono
        mode_sid: Boolean;      // 0 = Disabled         1 = Enabled                                                 SID
        mode_psg: Boolean;      // 0 = Disabled         1 = Enabled                                                 PSG
        mode_covox: Boolean;    // 0 = Disabled         1 = Enabled                                                 Covox
        core_mono: Byte;        // 1 = Both Channels    2 = Left only                                               Mono
        core_phi: Byte;         // 1 = PAL              2 = NTSC                                                    PHI2->1Mhz
        core_div1: Byte;        // 1 = 1                2 = 2               3 = 4                   4 = 8
        core_div2: Byte;        // 1 = 1                2 = 2               3 = 4                   4 = 8
        core_div3: Byte;        // 1 = 1                2 = 2               3 = 4                   4 = 8
        core_div4: Byte;        // 1 = 1                2 = 2               3 = 4                   4 = 8
        core_gtia1: Boolean;    // 0 = Disabled         1 = Enabled                                                 GTIA Channel Mixing
        core_gtia2: Boolean;    // 0 = Disabled         1 = Enabled         
        core_gtia3: Boolean;    // 0 = Disabled         1 = Enabled         
        core_gtia4: Boolean;    // 0 = Disabled         1 = Enabled         
        core_out1: Boolean;     // 0 = Disabled         1 = Enabled                                                 High R
        core_out2: Boolean;     // 0 = Disabled         1 = Enabled                                                 High L
        core_out3: Boolean;     // 0 = Disabled         1 = Enabled                                                 Low R
        core_out4: Boolean;     // 0 = Disabled         1 = Enabled                                                 Low L
        core_out5: Boolean;     // 0 = Disabled         1 = Enabled                                                 SPDIF
        pokey_mixing: Byte;     // 1 = Non-linear       2 = Linear
        pokey_channel: Byte;    // 1 = On               2 = Off
        pokey_irq: Byte;        // 1 = All              2 = One
        psg_freq: Byte;         // 1 = 2MHz             2 = 1MHz            3 = PHI2
        psg_stereo: Byte;       // 1 = Mono             2 = Polish          3 = Czech               4 = L/R
        psg_envelope: Byte;     // 1 = 32               2 = 16
        psg_volume: Byte;       // 1 = YM2149 Log 1     2 = AY Log          3 = YM2149 Log 2     4 = Linear
        sid_1: Byte;            // 1 = 6581             2 = 8580            3 = 8580 Digi
        sid_2: Byte;            // 1 = 6581             2 = 8580            3 = 8580 Digi
    end;

var 
    pmax_config: TPMAX_CONFIG;
    flash1, flash2: LongWord;


procedure PMAX_FlashInit;
(*
* @description:
* Reads Pokey registry and sets flash variable.
*)

procedure PMAX_ReadConfig;
(*
* @description:
* Reads PokeyMAX config settings and saves data in pmax_config record.
*)

// procedure PMAX_UpdateConfig;
(*
* @description:
* Reads pmax_config record and updates PokeyMAX config settings.
*)


function PMAX_GetPSG_Freq: Byte;
procedure PMAX_SetPSG_Freq(newval: Byte);

function PMAX_GetPSG_Stereo: Byte;
procedure PMAX_SetPSG_Stereo(newval: Byte);

function PMAX_GetPSG_Envelope: Byte;
procedure PMAX_SetPSG_Envelope(newval: Byte);

function PMAX_GetPSG_Volume: Byte;
procedure PMAX_SetPSG_Volume(newval: Byte);

function PMAX_GetSID_1: Byte;
procedure PMAX_SetSID_1(newval: Byte);

function PMAX_GetSID_2: Byte;
procedure PMAX_SetSID_2(newval: Byte);

implementation

function PMAX_GetPSG_Freq: Byte;
begin
    case (config[CONFIG_PSGMODE] and CONFIG_PSGMODE_FREQ) of
        0: pmax_config.psg_freq:= 1;
        1: pmax_config.psg_freq:= 2;
        2: pmax_config.psg_freq:= 3;
    end;
    Result:= pmax_config.psg_freq;
end;

procedure PMAX_SetPSG_Freq(newval: Byte);
begin
    pmax_config.psg_freq:=newval;
    case pmax_config.psg_freq of
        1: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_FREQ) or 0;
        2: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_FREQ) or 1;
        3: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_FREQ) or 2;
    end;
end;

function PMAX_GetPSG_Stereo: Byte;
begin
    case (config[CONFIG_PSGMODE] and CONFIG_PSGMODE_STEREO) of
        0: pmax_config.psg_stereo:= 1;
        4: pmax_config.psg_stereo:= 2;
        8: pmax_config.psg_stereo:= 3;
        12: pmax_config.psg_stereo:= 4;
    end;
    Result:= pmax_config.psg_stereo;
end;

procedure PMAX_SetPSG_Stereo(newval: Byte);
begin
    pmax_config.psg_stereo:=newval;
    case pmax_config.psg_stereo of
        1: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_STEREO) or 0;
        2: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_STEREO) or 4; 
        3: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_STEREO) or 8;
        4: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_STEREO) or 12;
    end;
end;

function PMAX_GetPSG_Envelope: Byte;
begin
    case (config[CONFIG_PSGMODE] and CONFIG_PSGMODE_ENVELOPE) of
        0: pmax_config.psg_envelope:= 1;
        16: pmax_config.psg_envelope:= 2;
    end;
    Result:= pmax_config.psg_envelope;
end;

procedure PMAX_SetPSG_Envelope(newval: Byte);
begin
    pmax_config.psg_envelope:=newval;
    case pmax_config.psg_envelope of
        1: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_ENVELOPE) or 0;
        2: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_ENVELOPE) or 16;
    end;
end;


function PMAX_GetPSG_Volume: Byte;
begin
    case (config[CONFIG_PSGMODE] and CONFIG_PSGMODE_VOLUME) of
        0: pmax_config.psg_volume:= 1;
        32: pmax_config.psg_volume:= 2;
        64: pmax_config.psg_volume:= 3;
        96: pmax_config.psg_volume:= 4; 
    end;
    Result:= pmax_config.psg_volume;
end;


procedure PMAX_SetPSG_Volume(newval: Byte);
begin
    pmax_config.psg_volume:=newval;
    case pmax_config.psg_volume of
        1: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 0;
        2: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 32; 
        3: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 64;
        4: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 96;
    end;
end;

function PMAX_GetSID_1: Byte;
begin
    if (config[CONFIG_SIDMODE] and CONFIG_SIDMODE_SID1TYPE) = 1 then pmax_config.sid_1:= 1
    else if (config[CONFIG_SIDMODE] and CONFIG_SIDMODE_SID1DIGI) = 0 then pmax_config.sid_1:= 2
    else pmax_config.sid_1:= 3;
    Result:= pmax_config.sid_1;
end;

procedure PMAX_SetSID_1(newval: Byte);
begin
    pmax_config.sid_1:=newval;
    if pmax_config.sid_1 = 1 then
    begin
     config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1TYPE) or 1;
     config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1DIGI) or 0;
    end
    else if pmax_config.sid_1 = 2 then
    begin
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1TYPE) or 0;
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1DIGI) or 0;
    end
    else begin
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1TYPE) or 0;
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID1DIGI) or 1;
    end;
end;

function PMAX_GetSID_2: Byte;
begin
    if (config[CONFIG_SIDMODE] and CONFIG_SIDMODE_SID2TYPE) = 1 then pmax_config.sid_2:= 1
    else if (config[CONFIG_SIDMODE] and CONFIG_SIDMODE_SID1DIGI) = 0 then pmax_config.sid_2:= 2
    else pmax_config.sid_2:= 3;
    Result:= pmax_config.sid_2;
end;

procedure PMAX_SetSID_2(newval: Byte);
begin
    pmax_config.sid_2:=newval;
    if pmax_config.sid_2 = 1 then
    begin
     config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2TYPE) or 1;
     config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2DIGI) or 0;
    end
    else if pmax_config.sid_2 = 2 then
    begin
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2TYPE) or 0;
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2DIGI) or 0;
    end
    else begin
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2TYPE) or 0;
        config[CONFIG_SIDMODE]:=(config[CONFIG_SIDMODE] and not CONFIG_SIDMODE_SID2DIGI) or 1;
    end;
end;


procedure PMAX_ReadConfig;
begin
    PMAX_GetPSG_Freq;
    PMAX_GetPSG_Stereo;
    PMAX_GetPSG_Envelope;
    PMAX_GetPSG_Volume;
    PMAX_GetSID_1;
    PMAX_GetSID_2;
end;


procedure PMAX_FlashInit;
begin
    flash1 := (LONGINT(config[5]) SHL 24) OR
              (LONGINT(config[3]) SHL 16) OR
              (LONGINT(config[2]) SHL 8) OR
              LONGINT(config[0]);
    
    flash2 := (LONGINT(config[9]) SHL 24) OR
              (LONGINT(config[7]) SHL 8) OR
              LONGINT(config[6]);
end;


// procedure PMAX_ReadConfig;
// var
//     val: Byte;
//     f : PLongWord;

// begin
//     PMAX_FlashInit;

//     ///////////////////////////////////////////////////////////////////////////
    
//     f:=@flash1;
//     val:= (f^ SHR $8) and $ff;
    
//     // Divide
//     case (val and $3) of 
//         0: pmax_config.core_div1:=1;
//         1: pmax_config.core_div1:=2;
//         2: pmax_config.core_div1:=3;
//         3: pmax_config.core_div1:=4;
//     end;

//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= ((f^ SHR $8) and $ff) SHR 2;

//     case (val and $3) of
//         0: pmax_config.core_div2:=1;
//         1: pmax_config.core_div2:=2;
//         2: pmax_config.core_div2:=3;
//         3: pmax_config.core_div2:=4;
//     end;

//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= ((f^ SHR $8) and $ff) SHR 4;

//     case (val and $3) of
//         0: pmax_config.core_div3:=1;
//         1: pmax_config.core_div3:=2;
//         2: pmax_config.core_div3:=3;
//         3: pmax_config.core_div3:=4;
//     end;

//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= ((f^ SHR $8) and $ff) SHR 6;

//     case (val and $3) of
//         0: pmax_config.core_div4:=1;
//         1: pmax_config.core_div4:=2;
//         2: pmax_config.core_div4:=3;
//         3: pmax_config.core_div4:=4;
//     end;


//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= (f^ SHR $10) and $ff; 
    
//     // GTIA
//     if (val and $1) = $1 then pmax_config.core_gtia1:=true
//     else pmax_config.core_gtia1:=false;

//     if ((val SHR 1) and $1) = $1 then pmax_config.core_gtia2:=true
//     else pmax_config.core_gtia2:=false;

//     if ((val SHR 2) and $1) = $1 then pmax_config.core_gtia3:=true
//     else pmax_config.core_gtia3:=false;

//     if ((val SHR 3) and $1) = $1 then pmax_config.core_gtia4:=true
//     else pmax_config.core_gtia4:=false;

//     ///////////////////////////////////////////////////////////////////////////

//     val:= f^ and $ff;

//     // CORE 1
//     if (val and $10) = $10 then pmax_config.core_mono:=1
//     else pmax_config.core_mono:=2;
    
//     if (val and $20) = $20 then pmax_config.core_phi:=1
//     else pmax_config.core_phi:=2;


//     // Pokey
//     if (val and 1) = $1 then pmax_config.pokey_mixing:=1
//     else pmax_config.pokey_mixing:=2;

//     if (val and 4) = $4 then pmax_config.pokey_channel:=1
//     else pmax_config.pokey_channel:=2;

//     if (val and 8) = $8 then pmax_config.pokey_irq:=1
//     else pmax_config.pokey_irq:=2;
//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= (f^ SHR $18) and $ff; 

//     // PSG
//     case (val and $3) of
//         0: pmax_config.psg_freq:=1;
//         1: pmax_config.psg_freq:=2;
//         2: pmax_config.psg_freq:=3;
//     end;

//     if (val and $10) = $10 then pmax_config.psg_envelope:=1
//     else pmax_config.psg_envelope:=2;


//     ///////////////////////////////////////////////////////////////////////////
//     val:= (((f^ SHR $18) and $ff) and $c) SHR 2; 

//     case val of
//         0: pmax_config.psg_stereo:=1;
//         1: pmax_config.psg_stereo:=2;
//         2: pmax_config.psg_stereo:=3;
//         3: pmax_config.psg_stereo:=4;
//     end;

//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= (((f^ SHR $18) and $ff) and $60) SHR $5; 

//     if (val = $3) then pmax_config.psg_volume:=1
//     else
//         case (val and $3) of
//             0: pmax_config.psg_volume:=2;
//             1: pmax_config.psg_volume:=3;
//             2: pmax_config.psg_volume:=4;
//         end;

//     ///////////////////////////////////////////////////////////////////////////

//     f:=@flash2;
//     val:= f^;

//     // SID 1
//     case (val and $3) of
//         0: pmax_config.sid_1:=1;
//         1: pmax_config.sid_1:=2;
//         2: pmax_config.sid_1:=3;
//     end;

//     // SID 2
//     case (val and $30) of
//         0: pmax_config.sid_1:=1;
//         16: pmax_config.sid_1:=2;
//         32: pmax_config.sid_1:=3;
//     end;


//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= (f^ SHR $18) and $1f; 
    
    
//     // Output
//     if (val and $1) = $1 then pmax_config.core_out1:=true
//     else pmax_config.core_out1:=false;

//     if ((val SHR 1) and $1) = $1 then pmax_config.core_out2:=true
//     else pmax_config.core_out2:=false;

//     if ((val SHR 2) and $1) = $1 then pmax_config.core_out3:=true
//     else pmax_config.core_out3:=false;

//     if ((val SHR 3) and $1) = $1 then pmax_config.core_out4:=true
//     else pmax_config.core_out4:=false;

//     if ((val SHR 4) and $1) = $1 then pmax_config.core_out5:=true
//     else pmax_config.core_out5:=false;


//     ///////////////////////////////////////////////////////////////////////////
    
//     val:= (f^ SHR $8) and $1f;

//     if (val and $2) = $2 then pmax_config.mode_option:=1
//     else if (val and $1) <> 0 then pmax_config.mode_option:=2
//     else pmax_config.mode_option:=3;

//     if (val and $4) = $4 then pmax_config.mode_sid:= true
//     else pmax_config.mode_sid:= false;

//     if (val and $8) = $8 then pmax_config.mode_psg:= true
//     else pmax_config.mode_psg:= false;

//     if (val and $10) = $10 then pmax_config.mode_covox:= true
//     else pmax_config.mode_covox:= false;
// end;


end. 