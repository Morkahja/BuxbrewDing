-- BuxbrewDing by Morkah
-- Announces RP/roleplay level-ups in guild chat and provides a /buxbrew test command.

-- RP-flavored messages 1..60 (unique & level-incorporated)
local LevelMessages = {
    [1]  = "Level 1 begins, and I step into Azeroth with wide eyes and trembling fists!",
    [2]  = "At level 2, I feel the thrill of adventure coursing through my veins!",
    [3]  = "Level 3! Kobolds beware — my blade hungers for its first foes!",
    [4]  = "Four steps in, and chaos follows in my wake!",
    [5]  = "Level 5! Victory tastes sweet on my sword, and I crave more!",
    [6]  = "At 6, even the forest trembles as I approach!",
    [7]  = "Level 7 grants me luck beyond measure, unlucky for my enemies!",
    [8]  = "Eight summers of life, and I strike swifter than the wind!",
    [9]  = "Nine battles deep, and I am just getting started!",
    [10] = "Level 10 awakens new talents; chaos walks beside me!",
    [11] = "At 11, every foe shall remember the day I passed through!",
    [12] = "Twelve victories mark my path, yet the journey continues!",
    [13] = "Level 13! Fate may frown, but I carve my own destiny!",
    [14] = "Fourteen strikes strong; even shadows flee at my approach!",
    [15] = "Halfway to 30 at level 15, and my spirit burns brighter!",
    [16] = "Sweet sixteen, and each step echoes with my triumphs!",
    [17] = "Level 17! Monsters whisper my name in fear before I strike!",
    [18] = "At 18, no longer a child, the world is my proving ground!",
    [19] = "Level 19 brings new horizons and fiercer resolve!",
    [20] = "Twenty summers strong; mounts and glory await me!",
    [21] = "At 21, my courage rivals the fiercest storms!",
    [22] = "Level 22! Every battle hones me sharper than any blade!",
    [23] = "Twenty-three steps into legend, I move unseen and unstoppable!",
    [24] = "Level 24 stretches the world wide, yet I feel larger than life!",
    [25] = "A quarter-century of daring deeds; my legend grows with 25!",
    [26] = "At 26, foes regret the moment they challenged me!",
    [27] = "Level 27! Adventure calls, and I answer boldly!",
    [28] = "Twenty-eight summers of skill, swift as wind, relentless as tide!",
    [29] = "Level 29! One final push before the next great milestone!",
    [30] = "Thirty! Epic mounts await, and legends whisper my name!",
    [31] = "At 31, my story spreads across every tavern and battlefield!",
    [32] = "Level 32! Shadows flee at my approach, heroes cheer my deeds!",
    [33] = "Thirty-three! Forests whisper my name with awe and fear!",
    [34] = "Level 34, each strike tells a tale, each foe humbled!",
    [35] = "Thirty-five summers climbed; the Plaguelands beckon me onward!",
    [36] = "At 36, steel and spell bend to my will as dungeons yield!",
    [37] = "Level 37! Deep caverns, dark forests — all feel my might!",
    [38] = "Thirty-eight! Enemies I once feared now flee at my shadow!",
    [39] = "At 39, my fire burns brighter than ever, unstoppable!",
    [40] = "Forty summers of life; mount polished, courage unshaken!",
    [41] = "Level 41! Power creeps into every strike I deliver!",
    [42] = "At 42, the answers of the world unfold as I step forward!",
    [43] = "Forty-three! Enemies tremble, for my name carries weight!",
    [44] = "Level 44! I carve my path through forests and foes alike!",
    [45] = "At 45, halfway to sixty, my epicness is undeniable!",
    [46] = "Level 46! Storms of war cannot shake my resolve!",
    [47] = "Forty-seven! Every clash sings a tale of my growing legend!",
    [48] = "At 48, shadows shrink, and my courage shines like dawn!",
    [49] = "Level 49! One step from fifty glory, nothing can halt me!",
    [50] = "Fifty summers strong; half a century of leveling chaos!",
    [51] = "Level 51! The battlegrounds echo with my name and deeds!",
    [52] = "At 52, my might stretches beyond what eyes can see!",
    [53] = "Fifty-three! Hawk-eyed and battle-ready, I press onward!",
    [54] = "Level 54! Danger courts me, yet I dance with it gladly!",
    [55] = "At 55, every foe adds to my growing legend!",
    [56] = "Level 56! My claws sharpened, my spirit unbroken!",
    [57] = "Fifty-seven! One foot in legend, the other still in Azeroth!",
    [58] = "At 58, whispers of endgame stir, and I answer with force!",
    [59] = "Level 59! Penultimate push, the summit of might awaits!",
    [60] = "Sixty! Champion of Turtle WoW, legend made, all hail me!",
}

-- saved var for last announced level
BuxbrewDing_LastLevel = BuxbrewDing_LastLevel or 0

-- helper: trim whitespace
local function trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end

-- announce function (only sends to guild when actually leveling)
local function AnnounceLevelToGuild(lvl)
    local msg = LevelMessages[lvl] or ("I rise to level " .. lvl .. "!")
    if IsInGuild() then
        SendChatMessage(msg, "GUILD")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r You are not in a guild; not sending.")
    end
end

-- preview function (prints locally, does NOT send guild chat)
local function PreviewLevel(lvl)
    local msg = LevelMessages[lvl] or ("I rise to level " .. lvl .. "!")
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing Preview "..lvl.."]|r "..msg)
end

-- frame & event handling
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEVEL_UP")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        -- initialize last level to current player level to avoid announcing old levels
        local cur = tonumber(UnitLevel("player")) or 0
        BuxbrewDing_LastLevel = cur
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99BuxbrewDing by Morkah loaded!|r Type |cffffff00/buxbrew help|r for commands.")
    elseif event == "PLAYER_LEVEL_UP" then
        -- PLAYER_LEVEL_UP passes the new level as the first arg
        local newLevel = tonumber(select(1, ...)) or tonumber(...)
        if newLevel and newLevel > BuxbrewDing_LastLevel and newLevel <= 60 then
            local msg = LevelMessages[newLevel] or ("I rise to level " .. newLevel .. "!")
            if IsInGuild() then
                SendChatMessage(msg, "GUILD")
            end
            BuxbrewDing_LastLevel = newLevel
        end
    end
end)

-- Slash command: /buxbrew
SLASH_BUXBREWDING1 = "/buxbrew"
SlashCmdList["BUXBREWDING"] = function(input)
    local text = trim(input or "")
    if text == "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Usage: |cffffff00/buxbrew help|r")
        return
    end

    local cmd, rest = text:match("^(%S+)%s*(.-)$")
    cmd = cmd and cmd:lower() or ""
    rest = trim(rest or "")

    -- if user typed a number directly: /buxbrew 30  (preview)
    if tonumber(cmd) then
        local lvl = tonumber(cmd)
        if lvl >= 1 and lvl <= 60 then
            PreviewLevel(lvl)
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Level must be 1-60.")
        end
        return
    end

    if cmd == "test" or cmd == "preview" then
        local lvl = tonumber(rest)
        if lvl and lvl >= 1 and lvl <= 60 then
            PreviewLevel(lvl)
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Usage: |cffffff00/buxbrew test <level>|r (1-60)")
        end
        return
    end

    if cmd == "announce" or cmd == "send" then
        local lvl = tonumber(rest)
        if lvl and lvl >= 1 and lvl <= 60 then
            if IsInGuild() then
                AnnounceLevelToGuild(lvl)
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Announced level "..lvl.." to guild.")
            else
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r You are not in a guild.")
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Usage: |cffffff00/buxbrew announce <level>|r (1-60)")
        end
        return
    end

    if cmd == "help" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Commands:")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffff00/buxbrew <n>|r - Preview message for level n (1-60)")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffff00/buxbrew test <n>|r - Preview message for level n")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffff00/buxbrew announce <n>|r - Send level n message to guild (requires guild)")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffff00/buxbrew help|r - Show this help")
        return
    end

    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[BuxbrewDing]|r Unknown command. Type |cffffff00/buxbrew help|r for usage.")
end
