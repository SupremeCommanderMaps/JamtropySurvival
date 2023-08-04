-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua');
local ScenarioFramework = import('/lua/ScenarioFramework.lua');
local Utilities = import('/lua/utilities.lua');
local Entity = import('/lua/sim/Entity.lua').Entity;

-- ColorCIVILIAN = 'FFCEA984'    -- CIVILIAN Color
-- ColorCybranRed = 'FFe80a0a'    -- Cybran red
-- ColorDarkRed = 'ff901427'    -- dark red
-- ColorNewFuschia = 'ffff32ff'    -- new fuschia
-- ColorPink = 'ffff88ff'    -- pink
-- ColorPurple = 'ff9161ff'    -- purple
-- ColorDarkPurple = 'FF5F01A7'   -- dark purple
-- ColorUEFblue = 'FF2929e1'    -- UEF blue
-- ColorNewBlue = 'ff436eee'    -- New blue
-- ColorAqua = 'ff66ffcc'    -- aqua
-- ColorNewGreen = 'ff2e8b57'    -- new green
-- ColorMidGreen = 'ff40bf40'    -- mid green
-- ColorDarkGreen = 'ff9fd802'    -- dark green
-- ColorSeraGolden = 'ffa79602'    -- Sera golden
-- ColorNewYellow = 'fffafa00'    -- new yellow
-- ColorNomadsOrange = 'FFFF873E'    -- Nomads orange
-- ColorNewBrown = 'ffb76518'    -- new brown
-- ColorWhite = 'ffffffff'    -- white
-- ColorGrey = 'ff616d7e'    -- Grey
-- ColorBlack = 'FF2F4F4F'    -- black

-- lefttop, leftcenter, leftbottom,  righttop, rightcenter, rightbottom, centertop, center, centerbottom



function TextMsg(Message, Fontsize, RGBColor, Duration, Location)
        PrintText(Message, Fontsize, 'ff' .. RGBColor, Duration , Location) 
end

function DisplayDialogBox(TextPosition, DialogueTable) -- TextPositions are left or right
    ForkThread(function(self)
        local Dialog = nil
        -- This is all screwed... why doesn't SetText work as it should ?
        if DialogueTable and (DialogueTable != nil) then
            for i, Dialogue in DialogueTable do
                Dialog = CreateDialogue(Dialogue.text, nil, TextPosition)
                if Dialogue.displayTime and Dialogue.displayTime > 0 then
                    WaitSeconds(Dialogue.displayTime)
                else
                    WaitSeconds(1)
                end
                    if (Dialog != nil) then
                    Dialog:Destroy()
                     WaitSeconds(0.01)
                end
            end
        end	
    end)
end 