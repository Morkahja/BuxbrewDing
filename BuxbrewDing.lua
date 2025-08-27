-- BuxbrewDing by Morkah
-- Announces your level-ups in guild chat with RP flavor

-- Table of RP level messages (unique and level-incorporated)
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
    [30] = "Thirty! Epic adventures await, and legends whisper my name!",
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

-- Create frame and register for level up
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LEVEL_UP")

-- Use the level passed by the event to avoid off-by-one errors
frame:SetScript("OnEvent", function(self, event, newLevel)
    local lvl = tonumber(newLevel) or UnitLevel("player")
    if lvl and lvl <= 60 then
        local msg = LevelMessages[lvl] or ("I rise to level " .. lvl .. "!")
        if IsInGuild() then
            SendChatMessage(msg, "GUILD")
        end
    end
end)
