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
    CONFIG_MODE = $0;
    CONFIG_DIV = $2;
    CONFIG_GTIA = $3;
    CONFIG_PSGMODE = $5;
    CONFIG_SIDMODE = $6;
    CONFIG_RESTRICT = $7;
 
    // Masks
    CONFIG_MODE_CHANNEL = $4;
    CONFIG_MODE_MIXING = $1;               // old name Saturate
    CONFIG_MODE_IRQ = $8;
    CONFIG_MODE_MONO = $10;
    CONFIG_MODE_PHI = $20;                 // old name PAL

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
        mode_mono: Byte;        // 1 = Left only        2 = Both Channels                                           Mono
        mode_phi: Byte;         // 1 = NTSC             2 = PAL                                                    PHI2->1Mhz
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
        pokey_irq: Byte;        // 1 = One              2 = All
        psg_freq: Byte;         // 1 = 2MHz             2 = 1MHz            3 = PHI2
        psg_stereo: Byte;       // 1 = Mono             2 = Polish          3 = Czech               4 = L/R
        psg_envelope: Byte;     // 1 = 32               2 = 16
        psg_volume: Byte;       // 1 = YM2149 Log 1     2 = AY Log          3 = YM2149 Log 2        4 = Linear
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




// function PMAX_GetCORE_GTIA: Byte;
// procedure PMAX_SetCORE_GTIA(newval: Byte);

function PMAX_GetMODE_PHI: Byte;
procedure PMAX_SetMODE_PHI(newval: Byte);

function PMAX_GetMODE_Channel: Byte;
procedure PMAX_SetMODE_Channel(newval: Byte);

function PMAX_GetMODE_IRQ: Byte;
procedure PMAX_SetMODE_IRQ(newval: Byte);

function PMAX_GetMODE_Mono: Byte;
procedure PMAX_SetMODE_Mono(newval: Byte);

function PMAX_GetMODE_Mixing: Byte;
procedure PMAX_SetMODE_Mixing(newval: Byte);

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

function PMAX_GetMODE_PHI: Byte;
begin
    case (config[CONFIG_MODE] and CONFIG_MODE_PHI) of
        0: pmax_config.mode_phi:= 1;
        4: pmax_config.mode_phi:= 2;
    end;
    Result:= pmax_config.mode_phi;
end;

procedure PMAX_SetMODE_PHI(newval: Byte);
begin
    pmax_config.mode_phi:=newval;
    case pmax_config.mode_phi of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_PHI) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_PHI) or 4;
    end;
end;


function PMAX_GetMODE_Channel: Byte;
begin
    case (config[CONFIG_MODE] and CONFIG_MODE_CHANNEL) of
        0: pmax_config.pokey_channel:= 1;
        4: pmax_config.pokey_channel:= 2;
    end;
    Result:= pmax_config.pokey_channel;
end;

procedure PMAX_SetMODE_Channel(newval: Byte);
begin
    pmax_config.pokey_channel:=newval;
    case pmax_config.pokey_channel of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_CHANNEL) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_CHANNEL) or 4;
    end;
end;

function PMAX_GetMODE_IRQ: Byte;
begin
    case (config[CONFIG_MODE] and CONFIG_MODE_IRQ) of
        0: pmax_config.pokey_irq:= 1;
        8: pmax_config.pokey_irq:= 2;
    end;
    Result:= pmax_config.pokey_irq;
end;
procedure PMAX_SetMODE_IRQ(newval: Byte);
begin
    pmax_config.pokey_irq:=newval;
    case pmax_config.pokey_irq of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_IRQ) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_IRQ) or 8;
    end;
end;

function PMAX_GetMODE_Mono: Byte;
begin
    case (config[CONFIG_MODE] and CONFIG_MODE_MONO) of
        0: pmax_config.mode_mono:= 1;
        16: pmax_config.mode_mono:= 2;
    end;
    Result:= pmax_config.mode_phi;
end;

procedure PMAX_SetMODE_Mono(newval: Byte);
begin
    pmax_config.mode_mono:=newval;
    case pmax_config.mode_mono of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_MONO) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_MONO) or 16;
    end;
end;

function PMAX_GetMODE_Mixing: Byte;
begin
    case (config[CONFIG_MODE] and CONFIG_MODE_MIXING) of
        0: pmax_config.pokey_mixing:= 1;
        32: pmax_config.pokey_mixing:= 2;
    end;
    Result:= pmax_config.pokey_mixing;
end;

procedure PMAX_SetMODE_Mixing(newval: Byte);
begin
    pmax_config.pokey_mixing:=newval;
    case pmax_config.pokey_mixing of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_MIXING) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_MIXING) or 32;
    end;
end;


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
        1: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 32;
        2: config[CONFIG_PSGMODE]:=(config[CONFIG_PSGMODE] and not CONFIG_PSGMODE_VOLUME) or 0; 
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
    PMAX_GetMODE_PHI;
    PMAX_GetMODE_Channel;
    PMAX_GetMODE_IRQ;
    PMAX_GetMODE_Mono;
    PMAX_GetMODE_Mixing;
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


end. 