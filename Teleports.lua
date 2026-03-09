local _, _A = ...


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
    QuestMapFrame:SetDisplayMode(self.displayMode)
end


TeleportPanelSearchBoxMixin = {}

function TeleportPanelSearchBoxMixin:OnLoad()
    SearchBoxTemplate_OnLoad(self)
    self.Instructions:SetText("Search Teleports");
end

function TeleportPanelSearchBoxMixin:OnTextChanged()
    SearchBoxTemplate_OnTextChanged(self)
    local text = self:GetText()
    local parent = self:GetParent()
    parent:SetSearchText(text)
end


TeleportPanelMixin = {}

function TeleportPanelMixin:OnLoad()
    self.iconsPerRow = 7
    self.initialized = false
    self.spellIDToButtons = {}
    self.sharedCooldownButtons = {}
    self.allButtons = {}
    self.searchText = ""

    self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    self:SetScript("OnEvent", self.OnEvent)
end

function TeleportPanelMixin:OnShow()
    self:RefreshList()
end

function TeleportPanelMixin:SetSearchText(text)
    self.searchText = string.lower(text or "")
    self:ApplySearch()
end

function TeleportPanelMixin:ApplySearch()
    if self.searchText == "" then
        for _, button in ipairs(self.allButtons) do
            button:Show()
        end
        if self.separatorPool then
            for separator in self.separatorPool:EnumerateActive() do
                separator:Show()
            end
        end
        if self.rowPool then
            for row in self.rowPool:EnumerateActive() do
                row:Show()
            end
        end
    else
        for _, button in ipairs(self.allButtons) do
            button:Hide()
        end

        local visibleRows = {}
        for _, button in ipairs(self.allButtons) do
            if button.text and string.find(button.text, self.searchText, 1, true) then
                button:Show()
                local row = button:GetParent()
                if row then
                    visibleRows[row] = true
                end
            end
        end

        if self.rowPool then
            for row in self.rowPool:EnumerateActive() do
                if visibleRows[row] then
                    row:Show()
                else
                    row:Hide()
                end
            end
        end

        if self.separatorPool then
            for separator in self.separatorPool:EnumerateActive() do
                separator:Hide()
            end
        end
    end

    local container = self.ScrollFrame.Content
    container:Layout()
    container:Show()
    self.ScrollFrame:UpdateScrollChildRect()
end

function TeleportPanelMixin:RefreshList()
    if self.initialized then return end

    self.initialized = true
    self.rowLayoutIndex = 1

    wipe(self.spellIDToButtons)
    wipe(self.sharedCooldownButtons)
    wipe(self.allButtons)

    local container = self.ScrollFrame.Content

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

    if self.searchText and self.searchText ~= "" then
        self:ApplySearch()
    end
end

function TeleportPanelMixin:CreateSeparator(text)
    local separator = self.separatorPool:Acquire()
    separator.layoutIndex = self.rowLayoutIndex

    separator.Text:SetText(text)

    separator:Show()

    self.rowLayoutIndex = self.rowLayoutIndex + 1
end

function TeleportPanelMixin:CreateCommonRows()
    local class = select(3, UnitClass("player"))
    local prof1, prof2 = GetProfessions()
    local prof1Name = prof1 and GetProfessionInfo(prof1) or ""
    local prof2Name = prof2 and GetProfessionInfo(prof2) or ""
    local rows = {}
    local currentRow = {}
    for _, data in ipairs(_A.TeleportsCommon) do
        local shouldAdd = true
        if data.class then
            shouldAdd = (class == data.class)
        end
        if data.prof then
            shouldAdd = (prof1Name == data.prof or prof2Name == data.prof)
        end
        if shouldAdd and data.type == _A.TeleportType.Toy then
            shouldAdd = PlayerHasToy(data.id)
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
    local rows = {}
    local currentRow = {}
    for _, id in ipairs(_A.TeleportsSeason) do
        local data = _A.TeleportDungeonLookup[id]
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
    for _, teleports in ipairs(_A.TeleportsDungeon) do
        self:CreateSeparator(teleports.expansion)

        local rows = {}
        local currentRow = {}
        local dungeonList = {}
        for id, data in pairs(teleports.dungeons) do
            table.insert(dungeonList, {id = id, type = data.type})
        end
        table.sort(dungeonList, function(a, b) return a.id < b.id end)

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
    local raidList = {}
    for id, data in pairs(_A.TeleportsRaid) do
        if C_SpellBook.IsSpellKnown(id, Enum.SpellBookSpellBank.Player) then
            table.insert(raidList, {id = id, type = data.type})
        end
    end
    table.sort(raidList, function(a, b) return a.id < b.id end)

    for _, raid in ipairs(raidList) do
        table.insert(currentRow, {
            id = raid.id,
            type = raid.type
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

function TeleportPanelMixin:CreateRows(rows)
    for _, rowTeleports in ipairs(rows) do
        local row = self.rowPool:Acquire()
        row.layoutIndex = self.rowLayoutIndex

        for j, teleport in ipairs(rowTeleports) do
            if teleport.type == _A.TeleportType.Spell or teleport.type == _A.TeleportType.Class then
                self:CreateSpellEntry(teleport.id, row, j)
            elseif teleport.type == _A.TeleportType.Toy then
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
    local spellDescription = C_Spell.GetSpellDescription(spellID)

    if not spellInfo or not spellDescription then return end

    local entry = self.buttonPool:Acquire()
    entry:SetParent(row)
    entry.layoutIndex = layoutIndex
    entry.spellID = spellID
    entry.text = string.lower(spellInfo.name.."/"..spellDescription)

    entry.Icon:SetTexture(spellInfo.iconID)

    local isKnown = C_SpellBook.IsSpellKnown(entry.spellID, Enum.SpellBookSpellBank.Player)
    entry.Icon:SetDesaturated(not isKnown)

    entry:SetAttribute("item", nil)
    entry:SetAttribute("type", "spell")
    entry:SetAttribute("spell", entry.spellID)

    self:SetupButtonHandlers(entry)

    entry:Show()

    table.insert(self.allButtons, entry)
end

function TeleportPanelMixin:CreateToyEntry(toyID, row, layoutIndex)
    local itemID, itemName, itemIcon = C_ToyBox.GetToyInfo(toyID)
    local spellName, spellID = C_Item.GetItemSpell(toyID)
    local spellDescription = spellID and C_Spell.GetSpellDescription(spellID) or nil

    if not itemID or not itemIcon or not spellID or not spellDescription then return end

    local entry = self.buttonPool:Acquire()
    entry:SetParent(row)
    entry.layoutIndex = layoutIndex
    entry.spellID = spellID
    entry.text = string.lower(itemName.."/"..spellName.."/"..spellDescription)

    entry.Icon:SetTexture(itemIcon)

    entry:SetAttribute("spell", nil)
    entry:SetAttribute("type", "item")
    entry:SetAttribute("item", "item:" .. itemID)

    self:SetupButtonHandlers(entry)

    entry:Show()

    table.insert(self.allButtons, entry)
end

function TeleportPanelMixin:SetupButtonHandlers(entry)
    local cooldownInfo = C_Spell.GetSpellCooldown(entry.spellID)
    self:SetEntryCooldown(entry, cooldownInfo)

    entry:SetScript("OnEnter", function(self)
        GameTooltip:ClearLines()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(self.spellID)
        GameTooltip:Show()
        self.IconHighlight:Show()
    end)

    entry:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        self.IconHighlight:Hide()
    end)

    if not self.spellIDToButtons[entry.spellID] then
        self.spellIDToButtons[entry.spellID] = {}
    end
    table.insert(self.spellIDToButtons[entry.spellID], entry)

    if self:IsSharedCooldown(entry.spellID) then
        table.insert(self.sharedCooldownButtons, entry)
    end
end

function TeleportPanelMixin:IsSharedCooldown(spellID)
    return _A.TeleportDungeonLookup[spellID] ~= nil
end

function TeleportPanelMixin:SetEntryCooldown(entry, cooldownInfo)
    if cooldownInfo.startTime > 0 then
        entry.Cooldown:SetCooldown(cooldownInfo.startTime, cooldownInfo.duration)
    else
        entry.Cooldown:Clear()
    end
end

function TeleportPanelMixin:OnEvent(event, spellID)
    if not spellID then return end

    local cooldownInfo = C_Spell.GetSpellCooldown(spellID)

    if not cooldownInfo or issecretvalue(cooldownInfo.startTime) then return end

    if self:IsSharedCooldown(spellID) then
        for _, button in ipairs(self.sharedCooldownButtons) do
            self:SetEntryCooldown(button, cooldownInfo)
        end
    else
        local buttons = self.spellIDToButtons[spellID]
        if buttons then
            for _, button in ipairs(buttons) do
                self:SetEntryCooldown(button, cooldownInfo)
            end
        end
    end
end