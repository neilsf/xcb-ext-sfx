# xcb-ext-sfx

XC=BASIC extension for playing sound effects in Shoot'em Up Construction Kit ([S.E.U.C.K](https://www.c64-wiki.com/wiki/S.E.U.C.K.)) format. Compatible with XC=BASIC v2.2 or higher. [Click here to learn about XC=BASIC](https://xc-basic.net). 

The extension uses [the routines written by Martin Piper](https://github.com/martinpiper/C64Public/tree/master/SFX).

Using this extension you'll be able to import and play sound effects from S.E.U.C.K. The sound effects can be played individually in the SID's three voices. Optionnally, you can reserve voice no 3 for your own sound effects.

# Usage

Include the file `xcb-ext-sfx.bas` in the top of your program:

    include "path/to/xcb-ext-sfx.bas"

# Examples

Please refer to the file `examples/test.bas` for an example. This example file plays the sound effects from the S.E.U.C.K game Outlaw.

# Quick start

The first thing you'll have to do is import the SFX data. When you save SFX in S.E.U.C.K, it will write 242 bytes on disk, a 2-byte load address and 240 bytes of data, 10 bytes per sound. To import this data into your program, you can:

- Load the file into RAM in runtime using the `LOAD` statement, or
- Include the file in your source code in compile time using the `INCBIN` statement.

Either way, you'll have to pass the address of SXF data to the `sfx_init` procedure.

Here's an examples to load data in runtime:

    rem -- load sfx data in runtime
    include "path/to/xcb-ext-sfx.bas"
    load "mysfx",8,1 : rem -- data will be loaded to the addres
                       rem -- specified in the first 2 bytes of the file
                       rem -- let's suppose it's $4000
    sfx_init $4000, 0

Another example to include data in compile time:

    rem -- include sfx data in compile time
    include "path/to/xcb-ext-sfx;bas"
    sfx_init @sfxdat, 0
    
    sfxdat:
    incbin "path/to/mysfx.bin"

Now that SFX data is loaded, we need to set up a loop that calls the play routine on each screen refresh. You can achieve this using the [raster interrupt extension](https://github.com/neilsf/xcb-ext-rasterinterrupt) or simply waiting for the raster beam to reach a specific line number:

    const VIC_RASTER = $d012
    loop:
      watch VIC_RASTER, 100
      sfx_play
      goto loop

Now the routine is running and "listening" to your commands. The only one thing left to do is start a sound effect:

    sfx_start sound_no!
    
Where `sound_no!` is the number of sound, from 0 to 23.

# Detailed documentation

## Commands defined in this extension

### sfx_init &lt;sfx_addr>, &lt;voice3_reserved!>

Initializes SID and sets up the play routine. Parameters:

- `sfx_addr` the address where sfx data are found in memory
- `voice3_reserved!` whether the routine should exclude SID's voice no 3 from playing (1=yes, 0=no)

### sfx_play

This command must be issued on every screen refresh (or every 1/50th of a second) in order to play sounds.

### sfx_start &lt;sound_no!>

Starts a sound. The only parameter is `sound_no!`, the number of sound, from 0 to 23.

## Constants defined in this extension
    
    const SFX_SID       		      = $D400
    const SFX_SIDVOICE1FREQLO         = $D400
    const SFX_SIDVOICE1FREQHI		  = $D401
    const SFX_SIDVOICE1PULSEWIDTHLO	  = $D402
    const SFX_SIDVOICE1PULSEWIDTHHI	  = $D403
    const SFX_SIDVOICE1CONTROL	      = $D404
    const SFX_SIDVOICE1ATTACKDECAY	  = $D405
    const SFX_SIDVOICE1SUSTAINRELEASE = $D406
    const SFX_SIDVOICE2FREQLO		  = $D407
    const SFX_SIDVOICE2FREQHI		  = $D408
    const SFX_SIDVOICE2PULSEWIDTHLO	  = $D409
    const SFX_SIDVOICE2PULSEWIDTHHI	  = $D40A
    const SFX_SIDVOICE2CONTROL	      = $D40B
    const SFX_SIDVOICE2ATTACKDECAY	  = $D40C
    const SFX_SIDVOICE2SUSTAINRELEASE = $D40D
    const SFX_SIDVOICE3FREQLO         = $D40E
    const SFX_SIDVOICE3FREQHI	      = $D40F
    const SFX_SIDVOICE3PULSEWIDTHLO	  = $D410
    const SFX_SIDVOICE3PULSEWIDTHHI	  = $D411
    const SFX_SIDVOICE3CONTROL        = $D412
    const SFX_SIDVOICE3ATTACKDECAY	  = $D413
    const SFX_SIDVOICE3SUSTAINRELEASE = $D414
    const SFX_SIDFILTERCUTOFFFREQLO	  = $D415
    const SFX_SIDFILTERCUTOFFFREQHI	  = $D416
    const SFX_SIDFILTERCONTROL		  = $D417
    const SFX_SIDVOLUMEFILTER		  = $D418
    const SFX_SIDVOICE3WAVEFORMOUTPUT = $D41B
    const SFX_SIDVOICE3ADSROUTPUT	  = $D41C
    const SFX_VOICEWORKSIZE!          = 13