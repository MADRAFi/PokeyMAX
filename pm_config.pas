unit pm_config;
(*
* @type: unit
* @author: MADRAFi <madrafi@gmail.com>
* @name: PokeyMAX config library.
* @version: 0.1.0

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

    CONFIG_DIV_CH0 = $3;
    CONFIG_DIV_CH1 = $c;
    CONFIG_DIV_CH2 = $30;
    CONFIG_DIV_CH3 = $C0;

    CONFIG_GTIA_CH0 = $1;
    CONFIG_GTIA_CH1 = $2;
    CONFIG_GTIA_CH2 = $4;
    CONFIG_GTIA_CH3 = $8;

    CONFIG_RESTRICT_POKEY = $3;
    CONFIG_RESTRICT_SID = $4;
    CONFIG_RESTRICT_PSG = $8;
    CONFIG_RESTRICT_COVOX = $16; 

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
        mode_pokey: Byte;       // 1 = Mono             2 = Stereo          3 = Quad
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

function PMAX_GetREST_Pokey: Byte;
procedure PMAX_SetREST_Pokey(newval: Byte);

function PMAX_GetREST_Sid: Boolean;
procedure PMAX_SetREST_Sid(newval: Boolean);

function PMAX_GetREST_Psg: Boolean;
procedure PMAX_SetREST_Psg(newval: Boolean);

function PMAX_GetREST_Covox: Boolean;
procedure PMAX_SetREST_Covox(newval: Boolean);

function PMAX_GetDIV_Ch0: Byte;
procedure PMAX_SetDIV_Ch0(newval: Byte);

function PMAX_GetDIV_Ch1: Byte;
procedure PMAX_SetDIV_Ch1(newval: Byte);

function PMAX_GetDIV_Ch2: Byte;
procedure PMAX_SetDIV_Ch2(newval: Byte);

function PMAX_GetDIV_Ch3: Byte;
procedure PMAX_SetDIV_Ch3(newval: Byte);

function PMAX_GetGTIA_Ch0: Boolean;
procedure PMAX_SetGTIA_Ch0(newval: Boolean);

function PMAX_GetGTIA_Ch1: Boolean;
procedure PMAX_SetGTIA_Ch1(newval: Boolean);

function PMAX_GetGTIA_Ch2: Boolean;
procedure PMAX_SetGTIA_Ch2(newval: Boolean);

function PMAX_GetGTIA_Ch3: Boolean;
procedure PMAX_SetGTIA_Ch3(newval: Boolean);

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
        32: pmax_config.mode_phi:= 2;
    end;
    Result:= pmax_config.mode_phi;
end;

procedure PMAX_SetMODE_PHI(newval: Byte);
begin
    pmax_config.mode_phi:=newval;
    case pmax_config.mode_phi of
        1: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_PHI) or 0;
        2: config[CONFIG_MODE]:=(config[CONFIG_MODE] and not CONFIG_MODE_PHI) or 32;
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

function PMAX_GetDIV_Ch0: Byte;
begin
    case (config[CONFIG_DIV] and CONFIG_DIV_CH0) of
        0: pmax_config.core_div1:= 1;
        1: pmax_config.core_div1:= 2;
        2: pmax_config.core_div1:= 3;
        3: pmax_config.core_div1:= 4;
    end;
    Result:= pmax_config.core_div1;
end;

procedure PMAX_SetDIV_Ch0(newval: Byte);
begin
    pmax_config.core_div1:=newval;
    case pmax_config.core_div1 of
        1: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH0) or 0;
        2: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH0) or 1;
        3: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH0) or 2;
        4: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH0) or 3;
    end;
end;

function PMAX_GetDIV_Ch1: Byte;
begin
    case (config[CONFIG_DIV] and CONFIG_DIV_CH1) of
        0: pmax_config.core_div2:= 1;
        4: pmax_config.core_div2:= 2;
        8: pmax_config.core_div2:= 3;
        12: pmax_config.core_div2:= 4;
    end;
    Result:= pmax_config.core_div2;
end;

procedure PMAX_SetDIV_Ch1(newval: Byte);
begin
    pmax_config.core_div2:=newval;
    case pmax_config.core_div2 of
        1: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH1) or 0;
        2: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH1) or 4;
        3: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH1) or 8;
        4: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH1) or 12;
    end;
end;

function PMAX_GetDIV_Ch2: Byte;
begin
    case (config[CONFIG_DIV] and CONFIG_DIV_CH2) of
        0: pmax_config.core_div3:= 1;
        16: pmax_config.core_div3:= 2;
        32: pmax_config.core_div3:= 3;
        48: pmax_config.core_div3:= 4;
    end;
    Result:= pmax_config.core_div3;
end;

procedure PMAX_SetDIV_Ch2(newval: Byte);
begin
    pmax_config.core_div3:=newval;
    case pmax_config.core_div3 of
        1: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH2) or 0;
        2: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH2) or 16;
        3: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH2) or 32;
        4: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH2) or 48;
    end;
end;

function PMAX_GetDIV_Ch3: Byte;
begin
    case (config[CONFIG_DIV] and CONFIG_DIV_CH3) of
        0: pmax_config.core_div4:= 1;
        64: pmax_config.core_div4:= 2;
        128: pmax_config.core_div4:= 3;
        192: pmax_config.core_div4:= 4;
    end;
    Result:= pmax_config.core_div4;
end;

procedure PMAX_SetDIV_Ch3(newval: Byte);
begin
    pmax_config.core_div4:=newval;
    case pmax_config.core_div4 of
        1: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH3) or 0;
        2: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH3) or 64;
        3: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH3) or 128;
        4: config[CONFIG_DIV]:=(config[CONFIG_DIV] and not CONFIG_DIV_CH3) or 192;
    end;
end;


function PMAX_GetGTIA_Ch0: Boolean;
begin
    case (config[CONFIG_GTIA] and CONFIG_GTIA_CH0) of
        0: pmax_config.core_gtia1:= false;
        1: pmax_config.core_gtia1:= true;
    end;
    Result:= pmax_config.core_gtia1;
end;

procedure PMAX_SetGTIA_Ch0(newval: Boolean);
begin
    pmax_config.core_gtia1:=newval;
    case pmax_config.core_gtia1 of
        false: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH0) or 0;
        true: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH0) or 1;
    end;
end;

function PMAX_GetGTIA_Ch1: Boolean;
begin
    case (config[CONFIG_GTIA] and CONFIG_GTIA_CH1) of
        0: pmax_config.core_gtia2:= false;
        2: pmax_config.core_gtia2:= true;
    end;
    Result:= pmax_config.core_gtia2;
end;

procedure PMAX_SetGTIA_Ch1(newval: Boolean);
begin
    pmax_config.core_gtia2:=newval;
    case pmax_config.core_gtia2 of
        false: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH1) or 0;
        true: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH1) or 2;
    end;
end;

function PMAX_GetGTIA_Ch2: Boolean;
begin
    case (config[CONFIG_GTIA] and CONFIG_GTIA_CH2) of
        0: pmax_config.core_gtia3:= false;
        4: pmax_config.core_gtia3:= true;
    end;
    Result:= pmax_config.core_gtia3;
end;

procedure PMAX_SetGTIA_Ch2(newval: Boolean);
begin
    pmax_config.core_gtia3:=newval;
    case pmax_config.core_gtia3 of
        false: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH2) or 0;
        true: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH2) or 4;
    end;
end;

function PMAX_GetGTIA_Ch3: Boolean;
begin
    case (config[CONFIG_GTIA] and CONFIG_GTIA_CH3) of
        0: pmax_config.core_gtia4:= false;
        8: pmax_config.core_gtia4:= true;
    end;
    Result:= pmax_config.core_gtia4;
end;

procedure PMAX_SetGTIA_Ch3(newval: Boolean);
begin
    pmax_config.core_gtia4:=newval;
    case pmax_config.core_gtia4 of
        false: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH3) or 0;
        true: config[CONFIG_GTIA]:=(config[CONFIG_GTIA] and not CONFIG_GTIA_CH3) or 8;
    end;
end;

function PMAX_GetREST_Pokey: Byte;
begin
    case (config[CONFIG_RESTRICT] and CONFIG_RESTRICT_POKEY) of
        0: pmax_config.mode_pokey:= 1;
        1: pmax_config.mode_pokey:= 2;
        10: pmax_config.mode_pokey:= 3;
    end;
    Result:= pmax_config.mode_pokey;
end;

procedure PMAX_SetREST_Pokey(newval: Byte);
begin
    pmax_config.mode_pokey:=newval;
    case pmax_config.mode_pokey of
        1: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_POKEY) or 0;
        2: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_POKEY) or 1;
        3: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_POKEY) or 10;
    end;
end;

function PMAX_GetREST_Sid: Boolean;
begin
    case (config[CONFIG_RESTRICT] and CONFIG_RESTRICT_POKEY) of
        0: pmax_config.mode_sid:= false;
        4: pmax_config.mode_sid:= true;
    end;
    Result:= pmax_config.mode_sid;
end;

procedure PMAX_SetREST_Sid(newval: Boolean);
begin
    pmax_config.mode_sid:=newval;
    case pmax_config.mode_sid of
        false: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_SID) or 0;
        true: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_SID) or 4;
    end;
end;


function PMAX_GetREST_Psg: Boolean;
begin
    case (config[CONFIG_RESTRICT] and CONFIG_RESTRICT_PSG) of
        0: pmax_config.mode_psg:= false;
        8: pmax_config.mode_psg:= true;
    end;
    Result:= pmax_config.mode_psg;
end;

procedure PMAX_SetREST_Psg(newval: Boolean);
begin
    pmax_config.mode_psg:=newval;
    case pmax_config.mode_psg of
        false: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_PSG) or 0;
        true: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_PSG) or 8;
    end;
end;

function PMAX_GetREST_Covox: Boolean;
begin
    case (config[CONFIG_RESTRICT] and CONFIG_RESTRICT_COVOX) of
        0: pmax_config.mode_covox:= false;
        8: pmax_config.mode_covox:= true;
    end;
    Result:= pmax_config.mode_covox;
end;

procedure PMAX_SetREST_Covox(newval: Boolean);
begin
    pmax_config.mode_covox:=newval;
    case pmax_config.mode_covox of
        false: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_COVOX) or 0;
        true: config[CONFIG_RESTRICT]:=(config[CONFIG_RESTRICT] and not CONFIG_RESTRICT_COVOX) or 8;
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
    PMAX_GetREST_Pokey;
    PMAX_GetREST_Sid;
    PMAX_GetREST_Psg;
    PMAX_GetREST_Covox;
    PMAX_GetDIV_Ch0;
    PMAX_GetDIV_Ch1;
    PMAX_GetDIV_Ch2;
    PMAX_GetDIV_Ch3;
    PMAX_GetGTIA_Ch0;
    PMAX_GetGTIA_Ch1;
    PMAX_GetGTIA_Ch2;
    PMAX_GetGTIA_Ch3;
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