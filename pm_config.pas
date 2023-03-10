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

var 
    // pokey: array [0..0] of byte absolute $d200;
    // config: array [0..0] of byte absolute $d210;
    flash1, flash2: LongWord;

// const 

// function PMAX_Detect: Boolean;
(*
* @description:
* Checks if PokeyMAX is present. 
* It returns true when PokeyMAX is present.
*)


// function PMAX_GetPokey: Byte;
(*
* @description:
* Checks how many PokeyMAX Pokeys are present in the firmware. 
* It returns number of pokeys present.
*)

// procedure PMAX_EnableConfig(enabled: Boolean);
(*
* @description:
* Switches PokeyMAX config mode.
* Enabled means config area is selected.
* Disabled means config area is deselected.
*)


implementation

// function PMAX_Detect: Boolean;
// begin
//     if pokey[POKEY_CONFIG] <> 1 then
//         result:= false
//     else result:= true;
// end;


// function PMAX_GetPokey: Byte;
// begin
//     case (config[1] and $3) of
//         0: result:= 1;
//         1: result:= 2;
//         2: result:= 4;
//         3: result:= 4;
//     end;
// end;

// procedure PMAX_EnableConfig (enabled: Boolean);
// begin
//     if enabled then pokey[POKEY_CONFIG] := $3f
//     else pokey[POKEY_CONFIG] := 0;
 
// end;


end. 