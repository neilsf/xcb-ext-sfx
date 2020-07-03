rem SFX test

const VIC_RASTER = $d012

include "../xcb-ext-sfx.bas"

sound_no! = 0
call sfx_init(@sound_data, 1)

print "press any key to play sfx"

loop:
  watch VIC_RASTER, 100
  call sfx_play
  if inkey() > 0 then
    call sfx_start(sound_no!)
    inc sound_no!
  endif
  goto loop
end

sound_data:
incbin "outlaw.sfx"