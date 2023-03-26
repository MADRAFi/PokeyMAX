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
        psg_envelope: Byte;     // 1 = 16               2 = 32
        psg_volume: Byte;       // 1 = Linear           2 = Log 0           3 = Log 1               4 = Log 2
        sid_1: Byte;            // 1 = 8580             2 = 6581            3 = 8580 Digi
        sid_2: Byte;            // 1 = 8580             2 = 6581            3 = 8580 Digi
    end;

var 
    pmax_config: TPMAX_CONFIG;
    flash1, flash2: LongWord;

// const 

// function PMAX_Detect: Boolean;
(*
* @description:
* Checks if PokeyMAX is present. 
* It returns true when PokeyMAX is present.
*)

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

procedure PMAX_UpdateConfig;
(*
* @description:
* Reads pmax_config record and updates PokeyMAX config settings.
*)


implementation


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

procedure PMAX_ReadConfig;
var
    val: Byte;
    f : PLongWord;

begin
    PMAX_FlashInit;

    ///////////////////////////////////////////////////////////////////////////
    
    f:=@flash1;
    val:= (f^ SHR $8) and $ff;
    
    // Divide
    case (val and $3) of 
        0: pmax_config.core_div1:=1;
        1: pmax_config.core_div1:=2;
        2: pmax_config.core_div1:=3;
        3: pmax_config.core_div1:=4;
    end;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 2;

    case (val and $3) of
        0: pmax_config.core_div2:=1;
        1: pmax_config.core_div2:=2;
        2: pmax_config.core_div2:=3;
        3: pmax_config.core_div2:=4;
    end;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 4;

    case (val and $3) of
        0: pmax_config.core_div3:=1;
        1: pmax_config.core_div3:=2;
        2: pmax_config.core_div3:=3;
        3: pmax_config.core_div3:=4;
    end;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 6;

    case (val and $3) of
        0: pmax_config.core_div4:=1;
        1: pmax_config.core_div4:=2;
        2: pmax_config.core_div4:=3;
        3: pmax_config.core_div4:=4;
    end;


    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $10) and $ff; 
    
    // GTIA
    if (val and $1) = $1 then pmax_config.core_gtia1:=true
    else pmax_config.core_gtia1:=false;

    if ((val SHR 1) and $1) = $1 then pmax_config.core_gtia2:=true
    else pmax_config.core_gtia2:=false;

    if ((val SHR 2) and $1) = $1 then pmax_config.core_gtia3:=true
    else pmax_config.core_gtia3:=false;

    if ((val SHR 3) and $1) = $1 then pmax_config.core_gtia4:=true
    else pmax_config.core_gtia4:=false;

    ///////////////////////////////////////////////////////////////////////////

    val:= f^ and $ff;

    // CORE 1
    if (val and $10) = $10 then pmax_config.core_mono:=1
    else pmax_config.core_mono:=2;
    
    if (val and $20) = $20 then pmax_config.core_phi:=1
    else pmax_config.core_phi:=2;


    // Pokey
    if (val and 1) = $1 then pmax_config.pokey_mixing:=1
    else pmax_config.pokey_mixing:=2;

    if (val and 4) = $4 then pmax_config.pokey_channel:=1
    else pmax_config.pokey_channel:=2;

    if (val and 8) = $8 then pmax_config.pokey_irq:=1
    else pmax_config.pokey_irq:=2;
    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $18) and $ff; 

    // PSG
    case (val and $3) of
        0: pmax_config.psg_freq:=1;
        1: pmax_config.psg_freq:=2;
        2: pmax_config.psg_freq:=3;
    end;

    if (val and $10) = $10 then pmax_config.psg_envelope:=1
    else pmax_config.psg_envelope:=2;


    ///////////////////////////////////////////////////////////////////////////
    val:= (((f^ SHR $18) and $ff) and $c) SHR 2; 

    case val of
        0: pmax_config.psg_stereo:=1;
        1: pmax_config.psg_stereo:=2;
        2: pmax_config.psg_stereo:=3;
        3: pmax_config.psg_stereo:=4;
    end;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= (((f^ SHR $18) and $ff) and $60) SHR $5; 

    if (val = $3) then pmax_config.psg_volume:=1
    else
        case (val and $3) of
            0: pmax_config.psg_volume:=2;
            1: pmax_config.psg_volume:=3;
            2: pmax_config.psg_volume:=4;
        end;

    ///////////////////////////////////////////////////////////////////////////

    f:=@flash2;
    val:= f^;

    // SID 1
    case (val and $3) of
        0: pmax_config.sid_1:=1;
        1: pmax_config.sid_1:=2;
        2: pmax_config.sid_1:=3;
    end;

    // SID 2
    case (val and $30) of
        0: pmax_config.sid_1:=1;
        16: pmax_config.sid_1:=2;
        32: pmax_config.sid_1:=3;
    end;


    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $18) and $1f; 
    
    
    // Output
    if (val and $1) = $1 then pmax_config.core_out1:=true
    else pmax_config.core_out1:=false;

    if ((val SHR 1) and $1) = $1 then pmax_config.core_out2:=true
    else pmax_config.core_out2:=false;

    if ((val SHR 2) and $1) = $1 then pmax_config.core_out3:=true
    else pmax_config.core_out3:=false;

    if ((val SHR 3) and $1) = $1 then pmax_config.core_out4:=true
    else pmax_config.core_out4:=false;

    if ((val SHR 4) and $1) = $1 then pmax_config.core_out5:=true
    else pmax_config.core_out5:=false;


    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $8) and $1f;

    if (val and $2) = $2 then pmax_config.mode_option:=1
    else if (val and $1) <> 0 then pmax_config.mode_option:=2
    else pmax_config.mode_option:=3;

    if (val and $4) = $4 then pmax_config.mode_sid:= true
    else pmax_config.mode_sid:= false;

    if (val and $8) = $8 then pmax_config.mode_psg:= true
    else pmax_config.mode_psg:= false;

    if (val and $10) = $10 then pmax_config.mode_covox:= true
    else pmax_config.mode_covox:= false;
end;


procedure PMAX_UpdateConfig;
var
    val: Byte;
    f : PLongWord;

begin
    PMAX_FlashInit;

    ///////////////////////////////////////////////////////////////////////////
    
    f:=@flash1;
    val:= (f^ SHR $8) and $ff;
    
    // Divide
    case pmax_config.core_div1 of
        1: (val and $3):=0;
        2: (val and $3):=1;
        3: (val and $3):=2;
        4: (val and $3):=3;
    end;
    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 2;

    case pmax_config.core_div2 of
        1: (val and $3):=0;
        2: (val and $3):=1;
        3: (val and $3):=2;
        4: (val and $3):=3;
    end;
    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 4;

    case pmax_config.core_div3 of
        1: (val and $3):=0;
        2: (val and $3):=1;
        3: (val and $3):=2;
        4: (val and $3):=3;
    end;
    ///////////////////////////////////////////////////////////////////////////
    
    val:= ((f^ SHR $8) and $ff) SHR 6;

    case pmax_config.core_div4 of
        1: (val and $3):=0;
        2: (val and $3):=1;
        3: (val and $3):=2;
        4: (val and $3):=3;
    end;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $10) and $ff; 
    
    // GTIA
    if (pmax_config.core_gtia1 = true) then (val and $1):= $1 
    else (val and $1):= 0;

    if (pmax_config.core_gtia2 = true) then ((val SHR 1) and $1) := $1 
    else ((val SHR 1) and $1):= 0;

    if (pmax_config.core_gtia3 = true) then ((val SHR 2) and $1) := $1 
    else ((val SHR 2) and $1):= 0;

    if (pmax_config.core_gtia4 = true) then ((val SHR 3) and $1) := $1 
    else ((val SHR 3) and $1):= 0;

    ///////////////////////////////////////////////////////////////////////////

    val:= f^ and $ff;

    // CORE 1
    
    if (pmax_config.core_mono = 1) then (val and $10) := $10 
    else (val and $10) := 0;
    
    if (pmax_config.core_phi = 1) then (val and $20) := $20 
    else (val and $20) := 0;

    // Pokey

    if (pmax_config.pokey_mixing = 1) then (val and $1) := $1 
    else (val and $1) := 0

    if (pmax_config.pokey_channel = 4) then (val and $4) := $4 
    else (val and $4) := 0
    
    if (pmax_config.pokey_irq = 8) then (val and $8) := $8
    else (val and $8) := 0

    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $18) and $ff;

    // PSG
    case pmax_config.psg_freq of
        1: (val and $3):=0;
        2: (val and $3):=1;
        3: (val and $3):=2;
    end;

    if pmax_config.psg_envelope = 1 then (val and $10) := $10 
    else (val and $10) := 0;

    ///////////////////////////////////////////////////////////////////////////
    val:= (((f^ SHR $18) and $ff) and $c) SHR 2; 

    case pmax_config.psg_stereo of
        1: val:=0;
        2: val:=1;
        3: val:=2;
        4: val:=3;
    end;


    ///////////////////////////////////////////////////////////////////////////
    
    val:= (((f^ SHR $18) and $ff) and $60) SHR $5; 

    case pmax_config.psg_volume of
        1: val:= $3;
        2: (val and $3):= 0;
        3: (val and $3):= 1
        4: (val and $3):= 2
    end;

    ///////////////////////////////////////////////////////////////////////////

    f:=@flash2;
    val:= f^;

    // SID 1
    case pmax_config.sid_1 of
        1: (val and $3):= 0;
        2: (val and $3):= 1;
        3: (val and $3):= 2;
    end;

    // SID 2
    case pmax_config.sid_2 of
        1: (val and $30):= 0;
        2: (val and $30):= 16;
        3: (val and $30):= 32;
    end;


    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $18) and $1f; 
    
    
    // Output
    if (pmax_config.core_out1 = true) then (val and $1) := $1 
    else (val and $1) := 0;

    if (pmax_config.core_out2 = true) then ((val SHR 1) and $1) := $1 
    else ((val SHR 1) and $1) := 0;
    
    if (pmax_config.core_out3 = true) then ((val SHR 2) and $1) := $1 
    else ((val SHR 2) and $1) := 0;
    
    if (pmax_config.core_out4 = true) then ((val SHR 3) and $1) := $1 
    else ((val SHR 3) and $1) := 0;

    if (pmax_config.core_out5 = true) then ((val SHR 4) and $1) := $1 
    else ((val SHR 4) and $1) := 0;

    ///////////////////////////////////////////////////////////////////////////
    
    val:= (f^ SHR $8) and $1f;

    case pmax_config.mode_option of
        1: (val and $2) := $2;
        2: (val and $1) := $1;
        3: val:=0; 
    end;

    if (pmax_config.mode_sid = true) then (val and $4) := $4
    else (val and $4) := $0;
    
    if (pmax_config.mode_psg = true) then (val and $8) := $8
    else (val and $8) := $0;

    if (pmax_config.mode_covox = true) then (val and $10) := $10
    else (val and $10) := $0;

end;

end. 