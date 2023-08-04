-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')
local SimUIVars = import('/lua/sim/SimUIState.lua')

-- dialogueTable format
-- it's a table of 4 variables - vid, cue, text, and duration
-- ex. Hello = {
--   {vid=video, cue=false, bank=false, text='Hello World', duration = 5 },
-- }
--
--   - bank = audio bank
--   - cue = audio cue
--   - vid = video cue
--   - text:     text to be displayed on the screen
--   - delay: time before begin next dialogue in table in second
function Dialogue(dialogueTable, callback, critical, speaker)
    local canSpeak = true
    if speaker and speaker.Dead then
        canSpeak = false
    end

    if canSpeak then
        local dTable = table.deepcopy(dialogueTable)
        if callback then
            dTable.Callback = callback
        end
        if critical then
            dTable.Critical = critical
        end
        if ScenarioInfo.DialogueLock == nil then
            ScenarioInfo.DialogueLock = false
            ScenarioInfo.DialogueLockPosition = 0
            ScenarioInfo.DialogueQueue = {}
            ScenarioInfo.DialogueFinished = {}
        end
        table.insert(ScenarioInfo.DialogueQueue, dTable)
        if not ScenarioInfo.DialogueLock then
            ScenarioInfo.DialogueLock = true
            ForkThread(PlayDialogue)
        end
    end
end

function FlushDialogueQueue()
    if ScenarioInfo.DialogueQueue then
        for _, v in ScenarioInfo.DialogueQueue do
            v.Flushed = true
        end
    end
end

-- This function sends movie data to the sync table and saves it off for reloading in save games
function SetupMFDSync(movieTable, text)
    DisplayVideoText(text)
    Sync.PlayMFDMovie = {movieTable[1], movieTable[2], movieTable[3], movieTable[4] }
    ScenarioInfo.DialogueFinished[movieTable[1]] = false

    local tempText = LOC(text)
    local tempData = {}
    local nameStart = string.find(tempText, ']')
    if nameStart ~= nil then
        tempData.name = LOC("<LOC "..string.sub(tempText, 2, nameStart - 1)..">")
        tempData.text = string.sub(tempText, nameStart + 2)
    end

    local timeSecs = GetGameTimeSeconds()
    tempData.time = string.format("%02d:%02d:%02d", math.floor(timeSecs/360), math.floor(timeSecs/60), math.mod(timeSecs, 60))
    tempData.color = 'ffffffff'
    if movieTable[4] == 'UEF' then
        tempData.color = 'ff00c1ff'
    elseif movieTable[4] == 'Cybran' then
        tempData.color = 'ffff0000'
    elseif movieTable[4] == 'Aeon' then
        tempData.color = 'ff89d300'
    end

    AddTransmissionData(tempData)
    WaitForDialogue(movieTable[1])
end

function AddTransmissionData(entryData)
    SimUIVars.SaveEntry(entryData)
end

local ExtraMovies = ScenarioInfo.MapPath .. '/Resources/Movies/'

function PlayDialogue() -- Use this function to play dialogue
    while table.getn(ScenarioInfo.DialogueQueue) > 0 do
        local dTable = table.remove(ScenarioInfo.DialogueQueue, 1)
        if not dTable then WARN('dTable is nil, ScenarioInfo.DialogueQueue len is '..repr(table.getn(ScenarioInfo.DialogueQueue))) end
        if not dTable.Flushed and (not ScenarioInfo.OpEnded or dTable.Critical) then
            for _, v in dTable do
                if v ~= nil and not dTable.Flushed and (not ScenarioInfo.OpEnded or dTable.Critical) then
                    if not v.vid and v.bank and v.cue then
                        --[[
                            This part is for ONLY audio 
                            Doesnt take in acount currently audio playing 
                            Make sure nothing is playing at that time if used
                            TODO- Make Check if audio is playing
                        ]]
                        local cue = v.cue
                        local bank = v.bank
                        local sound = {Cue = cue, Bank = bank}
                        table.insert(Sync.Sounds, sound)
                        --table.insert(Sync.Voice, {Cue = v.cue, Bank = v.bank})
                        if not v.delay then
                            WaitSeconds(5)
                        end
                    end
                    if v.text and not v.vid then
                        if not v.vid then
                            DisplayMissionText(v.text)
                        end
                    end
                    if v.vid then
                        local vidText = ''
                        local movieData = {}
                        if v.text then
                            vidText = v.text
                        end

                        local MovieLocationCheck = string.sub(v.vid, 1, 1)  --[[
                            Movie Location Check = get the First Letter of Name of Video
                            Video's must be in map folder Resources/movies/
                            Video starts with X its a Forged Alliance video no video needed
                            ]]
                        local AudioLocationCheck = string.sub(v.bank, 1, 1)
                        local cue = v.cue
                        local bank = v.bank

                        if MovieLocationCheck == 'A' then -- Supcom Vid
                            if GetMovieDuration(ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid) == 0 then
                                movieData = {'/movies/AllyCom.sfd', "", "", v.faction }
                            else
                                if AudioLocationCheck == 'X' then 
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, v.bank, v.cue, v.faction} -- If Audio is Used from Supcom FA
                                else
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, "", "", v.faction} -- "" used insed of v.bank, v.cue so we can play our own audio
                                    ForkThread(function()
                                        WaitSeconds(0.75)
                                        local sound = {Cue = cue, Bank = bank}
                                        table.insert(Sync.Sounds, sound)
                                    end)
                                end
                            end
                        end
                        if MovieLocationCheck == 'C' then -- Supcom Vid
                            if GetMovieDuration(ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid) == 0 then
                                movieData = {'/movies/AllyCom.sfd', v.bank, v.cue, v.faction }
                            else
                                if AudioLocationCheck == 'X' then
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, v.bank, v.cue, v.faction} -- If Audio is Used from Supcom FA
                                else
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, "", "", v.faction} -- "" used insed of v.bank, v.cue so we can play our own audio
                                    ForkThread(function()
                                        WaitSeconds(0.75)
                                        local sound = {Cue = cue, Bank = bank}
                                        table.insert(Sync.Sounds, sound)
                                    end)
                                end
                            end
                        end
                        if MovieLocationCheck == 'E' then -- Supcom Vid
                            if GetMovieDuration(ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid) == 0 then
                                movieData = {'/movies/AllyCom.sfd', v.bank, v.cue, v.faction }
                            else
                                if AudioLocationCheck == 'X' then
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, v.bank, v.cue, v.faction} -- If Audio is Used from Supcom FA
                                else
                                    movieData = {ScenarioInfo.MapPath .. 'Resources/movies/' .. v.vid, "", "", v.faction} -- "" used insed of v.bank, v.cue so we can play our own audio
                                    ForkThread(function()
                                        WaitSeconds(0.75)
                                        local sound = {Cue = cue, Bank = bank}
                                        table.insert(Sync.Sounds, sound)
                                    end)
                                end
                            end
                        end
                        if MovieLocationCheck == 'X' then -- Forged Alliance Vid
                            if GetMovieDuration('/movies/' .. v.vid) == 0 then
                                movieData = {'/movies/AllyCom.sfd', v.bank, v.cue, v.faction }
                            else
                                movieData = {'/movies/' .. v.vid, v.bank, v.cue, v.faction}
                            end
                        end

                        SetupMFDSync(movieData, vidText)
                    end
                    if v.delay and v.delay > 0 then
                        WaitSeconds(v.delay)
                    end
                    if v.duration and v.duration > 0 then
                        WaitSeconds(v.duration)
                    end
                end
            end
        end
        if dTable.Callback then
            ForkThread(dTable.Callback)
        end
        WaitTicks(1)
    end
    ScenarioInfo.DialogueLock = false
end

function WaitForDialogue(name)
    while not ScenarioInfo.DialogueFinished[name] do
        WaitTicks(1)
    end
end



-- Mission Text
function DisplayMissionText(string)
    if not Sync.MissionText then
        Sync.MissionText = {}
    end
    table.insert(Sync.MissionText, string)
end

-- Video Text
function DisplayVideoText(string)
    if not Sync.VideoText then
        Sync.VideoText = {}
    end
    table.insert(Sync.VideoText, string)
end



