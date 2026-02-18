local addonName, addonTable = ...

local factionGroup = UnitFactionGroup("player")

if factionGroup == "Horde" then
    siegeID = 464256
    motherID = 467555
elseif factionGroup == "Alliance" then
    siegeID = 445418
    motherID = 467553
end

addonTable.TeleportType = {
    Toy   = 1,
    Spell = 2,
    Item  = 3,
}

addonTable.TeleportsCommon = {
-- SPECIAL HEARTHSTONES (Toys)
    { id = 140192, type = addonTable.TeleportType.Toy }, -- Dalaran Hearthstone
    { id = 110560, type = addonTable.TeleportType.Toy }, -- Garrison Hearthstone
-- CLASSES
    { id = 50977, type = addonTable.TeleportType.Class, class = 6 }, -- DK Death Gate
    { id = 193753, type = addonTable.TeleportType.Class, class = 11 }, -- Druid Dreamwalk
-- WORMHOLES & TRANSPORTERS
    { id = 221966, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Khaz Algar (TWW)
    { id = 198156, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wyrmhole Generator: Dragon Isles (DF)
    { id = 172924, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Shadowlands (SL)
    { id = 168807, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Zandalar (BfA)
    { id = 168808, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Kul Tiras (BfA)
    { id = 151652, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Argus (Legion)
    { id = 112059, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Centrifuge (Draenor)
    { id = 87215, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Pandaria (MoP)
    { id = 48933, type = addonTable.TeleportType.Toy, prof = 8 }, -- Wormhole Generator: Northrend (WotLK)
    { id = 144341, type = addonTable.TeleportType.Toy, prof = 8 }, -- Rechargeable Reaves Battery (Legion Wormhole)
-- CLASSIC GADGETZAN/EVERLOOK TRANSPORTERS (Toys)
    { id = 18984, type = addonTable.TeleportType.Toy, prof = 8 }, -- Dimensional Ripper - Everlook
    { id = 18986, type = addonTable.TeleportType.Toy, prof = 8 }, -- Ultrasafe Transporter: Gadgetzan
    { id = 30542, type = addonTable.TeleportType.Toy, prof = 8 }, -- Dimensional Ripper - Area 52
    { id = 30544, type = addonTable.TeleportType.Toy, prof = 8 }, -- Ultrasafe Transporter: Toshley's Station
    { id = 167075, type = addonTable.TeleportType.Toy, prof = 8 }, -- Ultrasafe Transporter: Mechagon
}

addonTable.TeleportsSeason = {
    393273,
    1254572,
    1254559,
    1254563,
    1254555,
    1254551,
    1254557,
    1254400,
}

addonTable.TeleportsDungeonMidnight = {
    [1254572] = { type = addonTable.TeleportType.Spell }, -- Path of the Sun King (Magisters' Terrace)
    [1254559] = { type = addonTable.TeleportType.Spell }, -- Path of the Cavern (Maisara Caverns)
    [1254563] = { type = addonTable.TeleportType.Spell }, -- Path of the Ethereal (Nexus-Point Xenas)
    [1254400] = { type = addonTable.TeleportType.Spell }, -- Path of the Fallen (Windrunner Spire)
}
addonTable.TeleportsDungeonTheWarWithin = {
    [445417] = { type = addonTable.TeleportType.Spell }, -- Path of the Ruined City (Ara-Kara, City of Echoes)
    [445440] = { type = addonTable.TeleportType.Spell }, -- Path of the Flaming Brewery (Cinderbrew Meadery)
    [445416] = { type = addonTable.TeleportType.Spell }, -- Path of Nerubian Ascension (City of Threads)
    [445441] = { type = addonTable.TeleportType.Spell }, -- Path of the Warding Candles (Darkflame Cleft)
    [445414] = { type = addonTable.TeleportType.Spell }, -- Path of the Arathi Flagship (The Dawnbreaker)
    [1237215] = { type = addonTable.TeleportType.Spell }, -- Path of the Eco-Dome (Eco-Dome Al'dani)
    [1216786] = { type = addonTable.TeleportType.Spell }, -- Path of the Circuit Breaker (Operation: Floodgate)
    [445444] = { type = addonTable.TeleportType.Spell }, -- Path of the Light's Reverence (Priory of the Sacred Flame)
    [445443] = { type = addonTable.TeleportType.Spell }, -- Path of the Fallen Stormriders (The Rookery)
    [445269] = { type = addonTable.TeleportType.Spell }, -- Path of the Corrupted Foundry (The Stonevault)
}
addonTable.TeleportsDungeonDragonflight = {
    [393273] = { type = addonTable.TeleportType.Spell }, -- Path of the Draconic Diploma (Algeth'ar Academy)
    [393279] = { type = addonTable.TeleportType.Spell }, -- Path of Arcane Secrets (The Azure Vault)
    [393267] = { type = addonTable.TeleportType.Spell }, -- Path of the Rotting Woods (Brackenhide Hollow)
    [424197] = { type = addonTable.TeleportType.Spell }, -- Path of Twisted Time (Dawn of the Infinite)
    [393283] = { type = addonTable.TeleportType.Spell }, -- Path of the Titanic Reservoir (Halls of Infusion)
    [393276] = { type = addonTable.TeleportType.Spell }, -- Path of the Obsidian Hoard (Neltharus)
    [393262] = { type = addonTable.TeleportType.Spell }, -- Path of the Windswept Plains (The Nokhud Offensive)
    [393256] = { type = addonTable.TeleportType.Spell }, -- Path of the Clutch Defender (Ruby Life Pools)
    [393222] = { type = addonTable.TeleportType.Spell }, -- Path of the Watcher's Legacy (Uldaman: Legacy of Tyr)
}
addonTable.TeleportsDungeonShadowlands = {
    [354468] = { type = addonTable.TeleportType.Spell }, -- Path of the Scheming Loa (De Other Side)
    [354465] = { type = addonTable.TeleportType.Spell }, -- Path of the Sinful Soul (Halls of Atonement)
    [354464] = { type = addonTable.TeleportType.Spell }, -- Path of the Misty Forest (Mists of Tirna Scithe)
    [354462] = { type = addonTable.TeleportType.Spell }, -- Path of the Courageous (The Necrotic Wake)
    [354463] = { type = addonTable.TeleportType.Spell }, -- Path of the Plagued (Plaguefall)
    [354469] = { type = addonTable.TeleportType.Spell }, -- Path of the Stone Warden (Sanguine Depths)
    [354466] = { type = addonTable.TeleportType.Spell }, -- Path of the Ascendant (Spires of Ascension)
    [367416] = { type = addonTable.TeleportType.Spell }, -- Path of the Streetwise Merchant (Tazavesh, the Veiled Market)
    [354467] = { type = addonTable.TeleportType.Spell }, -- Path of the Undefeated (Theater of Pain)
}
addonTable.TeleportsDungeonBattleForAzeroth = {
    [424187] = { type = addonTable.TeleportType.Spell }, -- Path of the Golden Tomb (Atal'Dazar)
    [410071] = { type = addonTable.TeleportType.Spell }, -- Path of the Freebooter (Freehold)
    [373274] = { type = addonTable.TeleportType.Spell }, -- Path of the Scrappy Prince (Operation: Mechagon)
    [siegeID] = { type = addonTable.TeleportType.Spell }, -- Path of the Besieged Harbor (Siege of Boralus)
    [motherID] = { type = addonTable.TeleportType.Spell }, -- Path of the Azerite Refinery (The MOTHERLODE!!)
    [410074] = { type = addonTable.TeleportType.Spell }, -- Path of Festering Rot (The Underrot)
    [424167] = { type = addonTable.TeleportType.Spell }, -- Path of Heart's Bane (Waycrest Manor)
}
addonTable.TeleportsDungeonLegion = {
    [424153] = { type = addonTable.TeleportType.Spell }, -- Path of Ancient Horrors (Black Rook Hold)
    [393766] = { type = addonTable.TeleportType.Spell }, -- Path of the Grand Magistrix (Court of Stars)
    [424163] = { type = addonTable.TeleportType.Spell }, -- Path of the Nightmare Lord (Darkheart Thicket)
    [393764] = { type = addonTable.TeleportType.Spell }, -- Path of Proven Worth (Halls of Valor)
    [373262] = { type = addonTable.TeleportType.Spell }, -- Path of the Fallen Guardian (Karazhan)
    [410078] = { type = addonTable.TeleportType.Spell }, -- Path of the Earth-Warder (Neltharion's Lair)
    [1254551] = { type = addonTable.TeleportType.Spell }, -- Path of Dark Dereliction Seat of the Triumvirate)
}
addonTable.TeleportsDungeonWarlordsOfDraenor = {
    [159897] = { type = addonTable.TeleportType.Spell }, -- Path of the Vigilant (Auchindoun)
    [159895] = { type = addonTable.TeleportType.Spell }, -- Path of the Bloodmaul (Bloodmaul Slag Mines)
    [159901] = { type = addonTable.TeleportType.Spell }, -- Path of the Verdant (The Everbloom)
    [159900] = { type = addonTable.TeleportType.Spell }, -- Path of the Dark Rail (Grimrail Depot)
    [159896] = { type = addonTable.TeleportType.Spell }, -- Path of the Iron Prow (Iron Docks)
    [159899] = { type = addonTable.TeleportType.Spell }, -- Path of the Crescent Moon (Shadowmoon Burial Grounds)
    [159898] = { type = addonTable.TeleportType.Spell }, -- Path of the Skies (Skyreach)
    [1254557] = { type = addonTable.TeleportType.Spell }, -- Path of the Crowning Pinnacle (Skyreach)
    [159902] = { type = addonTable.TeleportType.Spell }, -- Path of the Burning Mountain (Upper Blackrock Spire)
}
addonTable.TeleportsDungeonMistsOfPandaria = {
    [131225] = { type = addonTable.TeleportType.Spell }, -- Path of the Setting Sun (Gate of the Setting Sun)
    [131222] = { type = addonTable.TeleportType.Spell }, -- Path of the Mogu King (Mogu'shan Palace)
    [131232] = { type = addonTable.TeleportType.Spell }, -- Path of the Necromancer (Scholomance)
    [131231] = { type = addonTable.TeleportType.Spell }, -- Path of the Scarlet Blade (Scarlet Halls)
    [131229] = { type = addonTable.TeleportType.Spell }, -- Path of the Scarlet Mitre (Scarlet Monastery)
    [131228] = { type = addonTable.TeleportType.Spell }, -- Path of the Black Ox (Siege of Niuzao)
    [131206] = { type = addonTable.TeleportType.Spell }, -- Path of the Shado-Pan (Shado-Pan Monastery)
    [131205] = { type = addonTable.TeleportType.Spell }, -- Path of the Stout Brew (Stormstout Brewery)
    [131204] = { type = addonTable.TeleportType.Spell }, -- Path of the Jade Serpent (the Temple of the Jade Serpent)
}
addonTable.TeleportsDungeonCataclysm = {
    [445424] = { type = addonTable.TeleportType.Spell }, -- Path of the Twilight Fortress (Grim Batol)
    [424142] = { type = addonTable.TeleportType.Spell }, -- Path of the Tidehunter (Throne of the Tides)
    [410080] = { type = addonTable.TeleportType.Spell }, -- Path of Wind's Domain (The Vortex Pinnacle)
}
addonTable.TeleportsDungeonWrathOfTheLichKing = {
    [1254555] = { type = addonTable.TeleportType.Spell }, -- Path of Unyielding Blight Pit of Saron)
}

addonTable.TeleportsDungeon = {
    { expansion = "Midnight", dungeons = addonTable.TeleportsDungeonMidnight },
    { expansion = "The War Within", dungeons = addonTable.TeleportsDungeonTheWarWithin },
    { expansion = "Dragonflight", dungeons = addonTable.TeleportsDungeonDragonflight },
    { expansion = "Shadowlands", dungeons = addonTable.TeleportsDungeonShadowlands },
    { expansion = "Battle for Azeroth", dungeons = addonTable.TeleportsDungeonBattleForAzeroth },
    { expansion = "Legion", dungeons = addonTable.TeleportsDungeonLegion },
    { expansion = "Warlords of Draenor", dungeons = addonTable.TeleportsDungeonWarlordsOfDraenor },
    { expansion = "Pandaria", dungeons = addonTable.TeleportsDungeonMistsOfPandaria },
    { expansion = "Cataclysm", dungeons = addonTable.TeleportsDungeonCataclysm },
    { expansion = "Wrath of the Lich King", dungeons = addonTable.TeleportsDungeonWrathOfTheLichKing },
}

addonTable.TeleportDungeonLookup = {}
for _, teleports in ipairs(addonTable.TeleportsDungeon) do
    for id, data in pairs(teleports.dungeons) do
        addonTable.TeleportDungeonLookup[id] = data
    end
end

addonTable.TeleportsRaid = {
---- The War Within (11.0)
    [1226482] = { type = addonTable.TeleportType.Spell }, -- Path of the Full House (the Liberation of Undermine)
    [1239155] = { type = addonTable.TeleportType.Spell }, -- Path of the All-Devouring (Manaforge Omega)
---- Dragonflight (10.0)
    [432254] = { type = addonTable.TeleportType.Spell }, -- Path of the Primal Prison (the Vault of the Incarnates)
    [432257] = { type = addonTable.TeleportType.Spell }, -- Path of the Bitter Legacy (Aberrus, the Shadowed Crucible)
    [432258] = { type = addonTable.TeleportType.Spell }, -- Path of the Scorching Dream (Amirdrassil, the Dream's Hope)
---- Shadowlands (9.0)
    [373190] = { type = addonTable.TeleportType.Spell }, -- Path of the Sire (Castle Nathria)
    [373191] = { type = addonTable.TeleportType.Spell }, -- Path of the Tormented Soul (Sanctum of Domination)
    [373192] = { type = addonTable.TeleportType.Spell }, -- Path of the First Ones (Sepulcher of the First Ones)
}