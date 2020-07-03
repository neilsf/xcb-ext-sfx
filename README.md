# xcb-ext-sfx

XC=BASIC extension for playing sound effects in Shoot'em Up Construction Kit ([S.E.U.C.K](https://www.c64-wiki.com/wiki/S.E.U.C.K.)) format. Compatible with XC=BASIC v2.2 or higher. [Click here to learn about XC=BASIC](https://xc-basic.net). 

This is a conversion of [Martin Piper's routine(https://github.com/martinpiper/C64Public/tree/master/SFX)].

Using this extension you'll be able to import and play sound effects from S.E.U.C.K. The sound effects can be played individually in the SID's three channels. You can also reserve one channel for your own sound effects.

# Usage

Include the file `xcb-ext-sfx.bas` in the top of your program:

    include "path/to/xcb-ext-sfx.bas"

# Examples

Please refer to the file `examples/test.bas` for an example. This example file plays the sound effects from the S.E.U.C.K game Outlaw.

# Detailed instructions

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
    sfx_init($4000, 0)

Another example to include data in compile time:

    rem -- include sfx data in compile time
    include "path/to/xcb-ext-sfx.bas"
    sfx_init(@sfxdat, 0)
    
    sfxdat:
    incbin "path/to/mysfx.bin"

Now that SFX data is loaded, we need to set up a loop that calls the play routine on each screen refresh. You can achieve this using the [raster interrupt extension](https://github.com/neilsf/xcb-ext-rasterinterrupt) or simply waiting for the raster beam to reach a specific line number:

    const VIC_RASTER = $d012
    loop:
      watch VIC_RASTER, 100
      call sfx_play
      goto loop
      
Now the routine is running and "listening" to your commands. The only one thing left is to start a sound effect:

    call sfx_start(sound_no!)
    
Where `sound_no!` is the number of the sound, from 0 to 23.
