local addonName, addonTable = ...


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

    if not self.separatorPool then
        self.separatorPool = CreateFramePool("Button", container, "TeleportSeparatorTemplate")
    end
    self.separatorPool:ReleaseAll()

    if not self.rowPool then
        self.rowPool = CreateFramePool("Frame", container, "HorizontalLayoutFrameTemplate")
    end
    self.rowPool:ReleaseAll()

    if not self.buttonPool then
        self.buttonPool = CreateFramePool("Button", container, "TeleportButtonTemplate")
    end
    self.buttonPool:ReleaseAll()

    self:CreateCommonRows()
    self:CreateSeparator("Season")
    self:CreateSeasonRows()
    self:CreateDungeonRows()
    self:CreateSeparator("Raids")
    self:CreateRaidRows()

    container:Layout()
    container:Show()

    self.ScrollFrame:UpdateScrollChildRect()
end

function TeleportPanelMixin:CreateSeparator(text)
    local sep = self.separatorPool:Acquire()
    sep.layoutIndex = self.rowLayoutIndex

    sep.Text:SetText(text)

    sep:Show()

    self.rowLayoutIndex = self.rowLayoutIndex + 1
end

function TeleportPanelMixin:CreateCommonRows()
    local class = select(3, UnitClass("player"))
    local rows = {}
    local currentRow = {}
    for _, data in ipairs(addonTable.TeleportsCommon) do
        local shouldAdd = false
        if data.type == addonTable.TeleportType.Class then
            shouldAdd = (class == data.class)
        elseif data.type == addonTable.TeleportType.Toy then
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

            if #currentRow == self.iconsPerRow then
                table.insert(rows, currentRow)
                currentRow = {}
            end
        end
    end

    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateSeasonRows()
    local dungeonLookup = {}
    for _, teleports in ipairs(addonTable.TeleportsDungeon) do
        for id, data in pairs(teleports.dungeons) do
            dungeonLookup[id] = data
        end
    end

    local rows = {}
    local currentRow = {}
    for _, id in ipairs(addonTable.TeleportsSeason) do
        local data = dungeonLookup[id]
        if data then
            table.insert(currentRow, {
                id = id,
                type = data.type
            })

            if #currentRow == self.iconsPerRow then
                table.insert(rows, currentRow)
                currentRow = {}
            end
        end
    end

    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateDungeonRows()
    for _, teleports in ipairs(addonTable.TeleportsDungeon) do
        self:CreateSeparator(teleports.expansion)

        local rows = {}
        local currentRow = {}
        local dungeonList = {}
        for id, data in pairs(teleports.dungeons) do
            table.insert(dungeonList, {id = id, type = data.type})
        end

        for _, dungeon in ipairs(dungeonList) do
            table.insert(currentRow, {
                id = dungeon.id,
                type = dungeon.type
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
end

function TeleportPanelMixin:CreateRaidRows()
    local rows = {}
    local currentRow = {}
    for id, data in pairs(addonTable.TeleportsRaid) do
        if C_SpellBook.IsSpellKnown(id, Enum.SpellBookSpellBank.Player) then
            table.insert(currentRow, {
                id = id,
                type = data.type
            })

            if #currentRow == self.iconsPerRow then
                table.insert(rows, currentRow)
                currentRow = {}
            end
        end
    end

    if #currentRow > 0 then
        table.insert(rows, currentRow)
    end

    self:CreateRows(rows)
end

function TeleportPanelMixin:CreateRows(rows)
    for _, rowTeleports in ipairs(rows) do
        local row = self.rowPool:Acquire()
        row.layoutIndex = self.rowLayoutIndex

        for j, teleport in ipairs(rowTeleports) do
            if teleport.type == addonTable.TeleportType.Spell or teleport.type == addonTable.TeleportType.Class then
                self:CreateSpellEntry(teleport.id, row, j)
            elseif teleport.type == addonTable.TeleportType.Toy then
                self:CreateToyEntry(teleport.id, row, j)
            end
        end

        row:Layout()
        row:Show()

        self.rowLayoutIndex = self.rowLayoutIndex + 1
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

local function SetEntryCooldown(entry)
    local cooldownInfo = C_Spell.GetSpellCooldown(entry.spellID)
    if cooldownInfo and cooldownInfo.startTime > 0 then
        entry.Cooldown:SetCooldown(cooldownInfo.startTime, cooldownInfo.duration)
    else
        entry.Cooldown:Clear()
    end
end

function TeleportPanelMixin:CreateEntryHandlers(entry)
    SetEntryCooldown(entry)

    entry:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(self.spellID)
        GameTooltip:Show()
        self.IconHighlight:Show()
    end)

    entry:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        self.IconHighlight:Hide()
    end)

    entry:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
    entry:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    entry:SetScript("OnEvent", function(self, event, spellID)
        if spellID == self.spellID then
            SetEntryCooldown(self)
        end
    end)
end