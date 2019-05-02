--[[----------------------------------------------------------------------------

  Application Name:
  Bargraph_InspectorP

  Summary:
  Illumination of the bargraph LED.

  How to Run:
  A connected InpspectorP device is necessary to run this sample. Starting this
  sample is possible either by running the app (F5) or debugging (F7+F10). The
  result can be seen by looking at the bargraph LED.

  More Information:
  See the tutorial "Audio-visual Feedback InspectorP".

------------------------------------------------------------------------------]]

--Start of Global Scope---------------------------------------------------------

-- Test if the hardware is a 64x/65x or 63x by testing if BAR5_LED can be created.
local V2D65x = LED.create('BAR5_LED') -- Equals nil for 63x hardware

local bargraph = {}
for i = 1, 5 do
  bargraph[i] = LED.create('BAR' .. tostring(i - 1) .. '_LED') -- Note off-set between Lua and LED indices
end

if V2D65x ~= nil then -- Enable more LEDs if the hardware is 64x/65x
  bargraph[6] = V2D65x -- Already created above for implicit hardware check
  for i = 7, 10 do
    bargraph[i] = LED.create('BAR' .. tostring(i - 1) .. '_LED')
  end
end

local t = 400 -- Duration in ms

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

while true do
  if V2D65x ~= nil then -- Turn on LEDs 1-10 for 64x/65x hardware
    for i = 1, 10 do
      bargraph[i]:activate()
      Script.sleep(t)
    end
  else -- Turn on LEDs 1-5 for 63x hardware
    for i = 1, 5 do
      bargraph[i]:activate()
      Script.sleep(t)
    end
  end
  if V2D65x ~= nil then -- Turn off LEDs for 64x/65x hardware
    for i = 1, 10 do
      bargraph[i]:deactivate()
    end
  else -- Turn off LEDs for 63x hardware
    for i = 1, 5 do
      bargraph[i]:deactivate()
    end
  end
  Script.sleep(t)
end

--End of Function and Event Scope--------------------------------------------------
