BTP_SavedVars = BTP_SavedVars or {}

-- Midnight
local SPELL_DUMP = {
373190,
373191,
373192,
432254,
432257,
432258,
1226482,
1239155,
}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(event, ...)
    for _, spellID in ipairs(SPELL_DUMP) do
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        local description = C_Spell.GetSpellDescription(spellID)
        if spellInfo and description then
            local spell = {
                id = spellID,
                name = spellInfo.name,
                desc = description
            }

            table.insert(BTP_SavedVars, spell)
        else
            print("Invalid spellID: "..spellID)
        end
    end
end)
