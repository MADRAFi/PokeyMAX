unit pm_detect;
(*
* @type: unit
* @author: MADRAFi <madrafi@gmail.com>
* @name: PokeyMAX library pm_detect.
* @version: 0.0.1
*
* @description:
* Set of useful constants, and structures to work with ATARI PokeyMAX. 
* Usefull to detect presence of PokeyMAX and loaded CORE options.
*)

interface

var 
    pokey: array [0..0] of byte absolute $d200;
    config: array [0..0] of byte absolute $d210;
    [volatile] core: byte absolute $d214;

const 
    CORE_MONO = 1;
    CORE_DIVIDE = 2;
    CORE_GTIA = 3;
    CORE_RESTRICT = 4;
    CORE_OUTPUT = 5;
    CORE_PHI = 6;
    CORE_MAX = 6;

    POKEY_LINEAR = 1;
    POKEY_CHANNEL_MODE = 2;
    POKEY_IRQ = 3;
    POKEY_MAX = 3;

    PSG_FREQUENCY = 1;
    PSG_STEREO = 2;
    PSG_ENVELOPE = 3;
    PSG_VOLUME = 4; 
    PSG_MAX = 4;

    SID_TYPE = 1;
    SID_MAX = 1;


// my custom labels
    POKEY_DETECT = 12;
    CONFIG_TYPE = 1;
    CONFIG_VERSION = 4;

function PMAX_Detect: Boolean;
(*
* @description:
* Checks if PokeyMAX is present. 
* It returns true when PokeyMAX is present.
*)

function PMAX_isFlashPresent: Boolean;
(*
* @description:
* Checks if PokeyMAX has flash to save configuration. 
* It returns true when PokeyMAX flash is present.
*)

function PMAX_isSIDPresent: Boolean;
(*
* @description:
* Checks if PokeyMAX has SID present in the firmware. 
* It returns true when SID core is present.
*)

function PMAX_isPSGPresent: Boolean;
(*
* @description:
* Checks if PokeyMAX has PSG present in the firmware. 
* It returns true when PSG core is present.
*)

function PMAX_isCovoxPresent: Boolean;
(*
* @description:
* Checks if PokeyMAX has Covox present in the firmware. 
* It returns true when Covox core is present.
*)

function PMAX_isSamplePresent: Boolean;
(*
* @description:
* Checks if PokeyMAX has Sample present in the firmware. 
* It returns true when Sample core is present.
*)

function PMAX_GetPokey: Byte;
(*
* @description:
* Checks how many PokeyMAX Pokeys are present in the firmware. 
* It returns number of pokeys present.
*)

function PMAX_GetCoreVersion: String;
(*
* @description:
* Reads PokeyMAX firmware version. 
* It returns alphanumeric string that represents firmware version.
*)


procedure PMAX_EnableConfig(enabled: Boolean);
(*
* @description:
* Switches PokeyMAX config mode.
* Enabled means config area is selected.
* Disabled means config area is deselected.
*)


implementation

function PMAX_Detect: Boolean;
begin
    if pokey[POKEY_DETECT] <> 1 then
    // if pokey + POKEY_DETECT <> 1 then
        result:= false
    else result:= true;
end;

function PMAX_isFlashPresent: Boolean;
begin
    if (config[CONFIG_TYPE] and $40) = $40 then
    // if (config + CONFIG_TYPE and $40) = $40 then
        result:= true
    else result:= false;
end;

function PMAX_isSIDPresent: Boolean;
begin

    if (config[CONFIG_TYPE] and $4) = $4 then
    // if (config + CONFIG_TYPE and $4) = $4 then
        result:= true
    else result:= false;
end;

function PMAX_isPSGPresent: Boolean;
begin

    if (config[CONFIG_TYPE] and $8) = $8 then
    // if (config + CONFIG_TYPE and $8) = $8 then
        result:= true
    else result:= false;
end;

function PMAX_isCovoxPresent: Boolean;
begin

    if (config[CONFIG_TYPE] and $10) = $10 then
    // if (config + CONFIG_TYPE and $10) = $10 then
        result:= true
    else result:= false;
end;

function PMAX_isSamplePresent: Boolean;
begin

    if (config[CONFIG_TYPE] and $20) = $20 then
    // if (config + CONFIG_TYPE and $20) = $20 then
        result:= true
    else result:= false;
end;

function PMAX_GetPokey: Byte;
begin
    case (config[CONFIG_TYPE] and $3) of
        0: result:= 1;
        1: result:= 2;
        2: result:= 4;
        3: result:= 4;
    // if (config + CONFIG_TYPE and $3) = 0 then
    //     result:= 1
    // else if (config + CONFIG_TYPE and $3) = 1 then
    //     result:= 2
    // else if (config + CONFIG_TYPE and $3) = 2 then
    //     result:= 4
    // else if (config + CONFIG_TYPE and $3) = 3 then
    //     result:= 4;
    end;
end;

function PMAX_GetCoreVersion: String;
var
   i: Byte;
//    s: String;

begin
    result[0]:=chr(8);
    for i := 0 to 7 do
    begin
        core:= i;
        result[1 + i]:= chr(core);
    end;
    // result:= s;
end;

procedure PMAX_EnableConfig (enabled: Boolean);
begin
    if enabled then pokey[POKEY_DETECT] := $3f
    else pokey[POKEY_DETECT] := 0;
 
end;


end. 