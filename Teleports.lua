TeleportTabMixin = {}

function TeleportTabMixin:OnLoad()
    self.SelectedTexture:Hide()
    self.Icon:SetAtlas(self.activeAtlas)
    self.Icon:SetSize(24, 24)
    self.Icon:Show()
end

function TeleportTabMixin:OnClick()
    QuestMapFrame.TeleportPanel:RefreshList()

    QuestMapFrame:SetDisplayMode(self.displayMode)
end


TeleportPanelMixin = {}

-- Define the IDs you want to track
local TELEPORT_DATA = {
    { type = "item", id = 140192 }, -- Dalaran Hearthstone
    { type = "item", id = 110560 }, -- Garrison Hearthstone
    { type = "spell", id = 131232 }, -- Example: Dungeon Teleport (Temple of the Jade Serpent)
    { type = "spell", id = 393256 }, -- Example: Dungeon Teleport (Halls of Infusion)
}

function TeleportPanelMixin:RefreshList()
    local container = self.ScrollFrame.ScrollChild

    -- Clear existing buttons (if any)
    if not self.buttonPool then
        self.buttonPool = CreateFramePool("Button", container, "TeleportButtonTemplate")
    end
    self.buttonPool:ReleaseAll()

    for _, data in ipairs(TELEPORT_DATA) do
        local button = self.buttonPool:Acquire()
        button.type = data.type
        button.id = data.id

        if data.type == "spell" then
            local spellInfo = C_Spell.GetSpellInfo(data.id)
            if spellInfo then
                button.Text:SetText(spellInfo.name)
                button.Icon:SetTexture(spellInfo.iconID)
            end
        elseif data.type == "item" then
            local itemName = C_Item.GetItemNameByID(data.id)
            local itemIcon = C_Item.GetItemIconByID(data.id)
            button.Text:SetText(itemName or "Loading...")
            button.Icon:SetTexture(itemIcon or 134400) -- Default question mark
        end

        -- Handle Clicking
        button:SetScript("OnClick", function(self)
            if self.type == "spell" then
                CastSpellByID(self.id)
            elseif self.type == "item" then
                UseItemByName(self.id)
            end
        end)

        button:Show()
    end

    container:Layout()
    self.ScrollFrame:UpdateScrollChildRect()
end
