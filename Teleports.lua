local addonName, addonTable = ...

local TELEPORT_TYPE = addonTable.TeleportType
local TELEPORTS_COMMON = addonTable.TeleportsCommon
local TELEPORTS_SEASON = addonTable.TeleportsSeason
local TELEPORTS_DUNGEON = addonTable.TeleportsDungeon
local TELEPORTS_RAID = addonTable.TeleportsRaid


TeleportTabMixin = {}

function TeleportTabMixin:OnLoad()
    self.SelectedTexture:Hide()
    self.Icon:SetAtlas(self.activeAtlas)
    self.Icon:SetDesaturated(true)
    self.Icon:SetVertexColor(1.0, 0.82, 0)
    self.Icon:SetSize(30, 30)
    self.Icon:Show()

    self:RegisterEvent("ADDON_LOADED")
    self:SetScript("OnEvent", function(self, event, name)
        if name == "BetterTracker" or C_AddOns.IsAddOnLoaded("BetterTracker") then
            local parent = self:GetParent()
            if parent.WorldQuestTab then
                self:SetPoint("TOP", parent.WorldQuestTab, "BOTTOM", 0, -3)

                self:UnregisterEvent("ADDON_LOADED")
            end
        end
    end)
end

function TeleportTabMixin:OnClick()
    QuestMapFrame.TeleportPanel:RefreshList()

    QuestMapFrame:SetDisplayMode(self.displayMode)
end


TeleportPanelMixin = {}

function TeleportPanelMixin:RefreshList()
    if self.initialized then return end

    self.initialized = true
    self.iconsPerRow = 7
    self.rowLayoutIndex = 1

    local container = self.ScrollFrame.ScrollChild

    if not self.rowPool then
        self.rowPool = CreateFramePool("Frame", container, "HorizontalLayoutFrameTemplate")
    end
    self.rowPool:ReleaseAll()

    if not self.buttonPool then
        self.buttonPool = CreateFramePool("Button", container, "TeleportButtonTemplate")
    end
    self.buttonPool:ReleaseAll()

    self:CreateCommonRows()

    self:CreateSeasonRows()
    self:CreateDungeonRows()
    self:CreateRaidRows()

    container:Layout()
    container:Show()

    self.ScrollFrame:UpdateScrollChildRect()
end

function TeleportPanelMixin:CreateCommonRows()
    local class = select(3, UnitClass("player"))
    local rows = {}
    local currentRow = {}
    for _, data in ipairs(TELEPORTS_COMMON) do
        local shouldAdd = false
        if data.type == TELEPORT_TYPE.Class then
            shouldAdd = (class == data.class)
        elseif data.type == TELEPORT_TYPE.Toy then
            shouldAdd = PlayerHasToy(data.id)
        else
            shouldAdd = true
        end
        if shouldAdd then
            table.insert(currentRow, {
                id = data.id,
                type = data.type,
                class = data.class
            })
        end
        if #currentRow == self.iconsPerRow then
            table.insert(rows, currentRow)
            currentRow = {}
        end
    end
    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateSeasonRows()
    local rows = {}
    local currentRow = {}
    for _, id in ipairs(TELEPORTS_SEASON) do
        local data = TELEPORTS_DUNGEON[id]
        table.insert(currentRow, {
            id = id,
            type = data.type
        })
        if #currentRow == self.iconsPerRow then
            table.insert(rows, currentRow)
            currentRow = {}
        end
    end
    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateDungeonRows()
    local rows = {}
    local currentRow = {}
    for id, data in pairs(TELEPORTS_DUNGEON) do
        table.insert(currentRow, {
            id = id,
            type = data.type
        })
        if #currentRow == self.iconsPerRow then
            table.insert(rows, currentRow)
            currentRow = {}
        end
    end
    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateRaidRows()
    local rows = {}
    local currentRow = {}
    for id, data in pairs(TELEPORTS_RAID) do
        if C_SpellBook.IsSpellKnown(id, Enum.SpellBookSpellBank.Player) then
            table.insert(currentRow, {
                id = id,
                type = data.type
            })
        end
        if #currentRow == self.iconsPerRow then
            table.insert(rows, currentRow)
            currentRow = {}
        end
    end
    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateRows(rows)
    for i, rowTeleports in ipairs(rows) do
        local row = self.rowPool:Acquire()
        row.layoutIndex = self.rowLayoutIndex

        for j, teleport in ipairs(rowTeleports) do
            if teleport.type == TELEPORT_TYPE.Spell then
                self:CreateSpellEntry(teleport.id, row, j)
            elseif teleport.type == TELEPORT_TYPE.Toy then
                self:CreateToyEntry(teleport.id, row, j)
            elseif teleport.type == TELEPORT_TYPE.Class then
                self:CreateSpellEntry(teleport.id, row, j)
            end
        end

        row:Layout()
        row:Show()

        self.rowLayoutIndex = self.rowLayoutIndex + i
    end
end

function TeleportPanelMixin:CreateSpellEntry(spellID, row, layoutIndex)
    local spellInfo = C_Spell.GetSpellInfo(spellID)

    local entry = self.buttonPool:Acquire()
    entry:SetParent(row)
    entry.spellID = spellID
    entry.layoutIndex = layoutIndex

    entry.Icon:SetTexture(spellInfo.iconID)

    local isKnown = C_SpellBook.IsSpellKnown(entry.spellID, Enum.SpellBookSpellBank.Player)
    entry.Icon:SetDesaturated(not isKnown)

    entry:SetAttribute("item", nil)
    entry:SetAttribute("type", "spell")
    entry:SetAttribute("spell", entry.spellID)

    self:CreateEntryHandlers(entry)

    entry:Show()
end

function TeleportPanelMixin:CreateToyEntry(toyID, row, layoutIndex)
    local itemID, _, itemIcon = C_ToyBox.GetToyInfo(toyID)

    local entry = self.buttonPool:Acquire()
    entry:SetParent(row)
    entry.spellID = select(2, C_Item.GetItemSpell(itemID))
    entry.layoutIndex = layoutIndex

    entry.Icon:SetTexture(itemIcon)

    local isKnown = PlayerHasToy(itemID)
    entry.Icon:SetDesaturated(not isKnown)

    entry:SetAttribute("spell", nil)
    entry:SetAttribute("type", "item")
    entry:SetAttribute("item", "item:"..itemID)

    self:CreateEntryHandlers(entry)

    entry:Show()
end

function TeleportPanelMixin:CreateEntryHandlers(entry)
    entry:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        self.IconHighlight:Show()
        GameTooltip:SetSpellByID(self.spellID)
        GameTooltip:Show()
    end)

    entry:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        self.IconHighlight:Hide()
    end)

    entry:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    entry:SetScript("OnEvent", function(self, event, spellID)
        if spellID == self.spellID then
            local spellInfo = C_Spell.GetSpellCooldown(spellID)
            if spellInfo and spellInfo.startTime > 0 then
                self.Cooldown:SetCooldown(spellInfo.startTime, spellInfo.duration)
            else
                self.Cooldown:Clear()
            end
        end
    end)
end