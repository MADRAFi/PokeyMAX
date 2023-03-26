unit pm_detect;
(*
* @type: unit
* @author: MADRAFi <madrafi@gmail.com>
* @name: PokeyMAX library pm_detect.
* @version: 0.0.2
*
* @description:
* Set of useful constants, and structures to work with ATARI PokeyMAX. 
* Usefull to detect presence of PokeyMAX and loaded CORE options.
*)

interface

const 
    POKEY_ADDRESS = $d200;
    CONFIG_ADDRESS = $d210;

    // Address references
    CONFIG_WRITE = $c;
    CONFIG_PRESENCE = $1;
    CONFIG_VERSION = $4;

    // Masks
    CONFIG_PRESENT_FLASH = $40;
    CONFIG_PRESENT_SAMPLE = $20;
    CONFIG_PRESENT_COVOX = $10;
    CONFIG_PRESENT_PSG = $8;
    CONFIG_PRESENT_SID = $4;
    CONFIG_PRESENT_POKEY = $3;                      
    

var 
    [volatile] pokey: array [0..0] of byte absolute POKEY_ADDRESS;
    [volatile] config: array [0..0] of byte absolute CONFIG_ADDRESS;               // configuration
    [volatile] core_version: Byte absolute CONFIG_ADDRESS + CONFIG_VERSION;        // core version string

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

function PMAX_GetPokeys: Byte;
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
    if pokey[CONFIG_WRITE] = 1 then
        result:= true
    else result:= false;
end;

function PMAX_isFlashPresent: Boolean;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_FLASH = CONFIG_PRESENT_FLASH then
        result:= true
    else result:= false;
end;

function PMAX_isSIDPresent: Boolean;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_SID = CONFIG_PRESENT_SID then
        result:= true
    else result:= false;
end;

function PMAX_isPSGPresent: Boolean;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_PSG = CONFIG_PRESENT_PSG then
        result:= true
    else result:= false;
end;

function PMAX_isCovoxPresent: Boolean;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_COVOX = CONFIG_PRESENT_COVOX then
        result:= true
    else result:= false;
end;

function PMAX_isSamplePresent: Boolean;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_SAMPLE = CONFIG_PRESENT_SAMPLE then
        result:= true
    else result:= false;
end;

function PMAX_GetPokeys: Byte;
begin
    if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_POKEY = 3 then
        Result:= 4
    else if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_POKEY = 2 then
        Result:= 4
    else if (config[CONFIG_PRESENCE]) and CONFIG_PRESENT_POKEY = 1 then
        Result:= 2
    else Result:=1;
end;

function PMAX_GetCoreVersion: String;
var
    i: Byte;

begin
    result[0]:=#8;
    for i := 0 to 7 do
    begin
        // config[CONFIG_VERSION]:= i;
        // result[1 + i]:= chr(config[CONFIG_VERSION]);
        core_version:= i;
        result[1 + i]:= chr(core_version);
        
    end;
end;

procedure PMAX_EnableConfig (enabled: Boolean);
begin
    if enabled then pokey[CONFIG_WRITE]:= $3f
    else pokey[CONFIG_WRITE]:= 0;
 
end;


end. 