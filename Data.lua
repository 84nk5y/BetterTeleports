local _, _A = ...

local factionGroup = UnitFactionGroup("player")

if factionGroup == "Horde" then
    siegeID = 464256
    motherID = 467555
elseif factionGroup == "Alliance" then
    siegeID = 445418
    motherID = 467553
end

_A.TeleportType = {
    Toy   = 1,
    Spell = 2,
    Item  = 3,
}
local Type = _A.TeleportType

_A.TeleportsCommon = {
-- SPECIAL HEARTHSTONES (Toys)
    { id = 140192, type = Type.Toy }, -- Dalaran Hearthstone
    { id = 110560, type = Type.Toy }, -- Garrison Hearthstone
    { id = 253629, type = Type.Toy }, -- Personal Key to the Arcantina
-- CLASSES
    { id = 50977, type = Type.Class, class = 6 }, -- DK Death Gate
    { id = 193753, type = Type.Class, class = 11 }, -- Druid Dreamwalk
-- WORMHOLES & TRANSPORTERS
    { id = 221966, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Khaz Algar (TWW)
    { id = 198156, type = Type.Toy, prof = "Engineering" }, -- Wyrmhole Generator: Dragon Isles (DF)
    { id = 172924, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Shadowlands (SL)
    { id = 168807, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Zandalar (BfA)
    { id = 168808, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Kul Tiras (BfA)
    { id = 151652, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Argus (Legion)
    { id = 112059, type = Type.Toy, prof = "Engineering" }, -- Wormhole Centrifuge (Draenor)
    { id = 87215, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Pandaria (MoP)
    { id = 48933, type = Type.Toy, prof = "Engineering" }, -- Wormhole Generator: Northrend (WotLK)
    { id = 144341, type = Type.Toy, prof = "Engineering" }, -- Rechargeable Reaves Battery (Legion Wormhole)
-- CLASSIC GADGETZAN/EVERLOOK TRANSPORTERS (Toys)
    { id = 18984, type = Type.Toy, prof = "Engineering" }, -- Dimensional Ripper - Everlook
    { id = 18986, type = Type.Toy, prof = "Engineering" }, -- Ultrasafe Transporter: Gadgetzan
    { id = 30542, type = Type.Toy, prof = "Engineering" }, -- Dimensional Ripper - Area 52
    { id = 30544, type = Type.Toy, prof = "Engineering" }, -- Ultrasafe Transporter: Toshley's Station
    { id = 167075, type = Type.Toy, prof = "Engineering" }, -- Ultrasafe Transporter: Mechagon
}

_A.TeleportsSeason = {
    393273,
    1254572,
    1254559,
    1254563,
    1254555,
    1254551,
    1254557,
    1254400,
}

_A.TeleportsDungeonMidnight = {
    [1254572] = { type = Type.Spell }, -- Path of the Sun King (Magisters' Terrace)
    [1254559] = { type = Type.Spell }, -- Path of the Cavern (Maisara Caverns)
    [1254563] = { type = Type.Spell }, -- Path of the Ethereal (Nexus-Point Xenas)
    [1254400] = { type = Type.Spell }, -- Path of the Fallen (Windrunner Spire)
}
_A.TeleportsDungeonTheWarWithin = {
    [445417] = { type = Type.Spell }, -- Path of the Ruined City (Ara-Kara, City of Echoes)
    [445440] = { type = Type.Spell }, -- Path of the Flaming Brewery (Cinderbrew Meadery)
    [445416] = { type = Type.Spell }, -- Path of Nerubian Ascension (City of Threads)
    [445441] = { type = Type.Spell }, -- Path of the Warding Candles (Darkflame Cleft)
    [445414] = { type = Type.Spell }, -- Path of the Arathi Flagship (The Dawnbreaker)
    [1237215] = { type = Type.Spell }, -- Path of the Eco-Dome (Eco-Dome Al'dani)
    [1216786] = { type = Type.Spell }, -- Path of the Circuit Breaker (Operation: Floodgate)
    [445444] = { type = Type.Spell }, -- Path of the Light's Reverence (Priory of the Sacred Flame)
    [445443] = { type = Type.Spell }, -- Path of the Fallen Stormriders (The Rookery)
    [445269] = { type = Type.Spell }, -- Path of the Corrupted Foundry (The Stonevault)
}
_A.TeleportsDungeonDragonflight = {
    [393273] = { type = Type.Spell }, -- Path of the Draconic Diploma (Algeth'ar Academy)
    [393279] = { type = Type.Spell }, -- Path of Arcane Secrets (The Azure Vault)
    [393267] = { type = Type.Spell }, -- Path of the Rotting Woods (Brackenhide Hollow)
    [424197] = { type = Type.Spell }, -- Path of Twisted Time (Dawn of the Infinite)
    [393283] = { type = Type.Spell }, -- Path of the Titanic Reservoir (Halls of Infusion)
    [393276] = { type = Type.Spell }, -- Path of the Obsidian Hoard (Neltharus)
    [393262] = { type = Type.Spell }, -- Path of the Windswept Plains (The Nokhud Offensive)
    [393256] = { type = Type.Spell }, -- Path of the Clutch Defender (Ruby Life Pools)
    [393222] = { type = Type.Spell }, -- Path of the Watcher's Legacy (Uldaman: Legacy of Tyr)
}
_A.TeleportsDungeonShadowlands = {
    [354468] = { type = Type.Spell }, -- Path of the Scheming Loa (De Other Side)
    [354465] = { type = Type.Spell }, -- Path of the Sinful Soul (Halls of Atonement)
    [354464] = { type = Type.Spell }, -- Path of the Misty Forest (Mists of Tirna Scithe)
    [354462] = { type = Type.Spell }, -- Path of the Courageous (The Necrotic Wake)
    [354463] = { type = Type.Spell }, -- Path of the Plagued (Plaguefall)
    [354469] = { type = Type.Spell }, -- Path of the Stone Warden (Sanguine Depths)
    [354466] = { type = Type.Spell }, -- Path of the Ascendant (Spires of Ascension)
    [367416] = { type = Type.Spell }, -- Path of the Streetwise Merchant (Tazavesh, the Veiled Market)
    [354467] = { type = Type.Spell }, -- Path of the Undefeated (Theater of Pain)
}
_A.TeleportsDungeonBattleForAzeroth = {
    [424187] = { type = Type.Spell }, -- Path of the Golden Tomb (Atal'Dazar)
    [410071] = { type = Type.Spell }, -- Path of the Freebooter (Freehold)
    [373274] = { type = Type.Spell }, -- Path of the Scrappy Prince (Operation: Mechagon)
    [siegeID] = { type = Type.Spell }, -- Path of the Besieged Harbor (Siege of Boralus)
    [motherID] = { type = Type.Spell }, -- Path of the Azerite Refinery (The MOTHERLODE!!)
    [410074] = { type = Type.Spell }, -- Path of Festering Rot (The Underrot)
    [424167] = { type = Type.Spell }, -- Path of Heart's Bane (Waycrest Manor)
}
_A.TeleportsDungeonLegion = {
    [424153] = { type = Type.Spell }, -- Path of Ancient Horrors (Black Rook Hold)
    [393766] = { type = Type.Spell }, -- Path of the Grand Magistrix (Court of Stars)
    [424163] = { type = Type.Spell }, -- Path of the Nightmare Lord (Darkheart Thicket)
    [393764] = { type = Type.Spell }, -- Path of Proven Worth (Halls of Valor)
    [373262] = { type = Type.Spell }, -- Path of the Fallen Guardian (Karazhan)
    [410078] = { type = Type.Spell }, -- Path of the Earth-Warder (Neltharion's Lair)
    [1254551] = { type = Type.Spell }, -- Path of Dark Dereliction Seat of the Triumvirate)
}
_A.TeleportsDungeonWarlordsOfDraenor = {
    [159897] = { type = Type.Spell }, -- Path of the Vigilant (Auchindoun)
    [159895] = { type = Type.Spell }, -- Path of the Bloodmaul (Bloodmaul Slag Mines)
    [159901] = { type = Type.Spell }, -- Path of the Verdant (The Everbloom)
    [159900] = { type = Type.Spell }, -- Path of the Dark Rail (Grimrail Depot)
    [159896] = { type = Type.Spell }, -- Path of the Iron Prow (Iron Docks)
    [159899] = { type = Type.Spell }, -- Path of the Crescent Moon (Shadowmoon Burial Grounds)
    [159898] = { type = Type.Spell }, -- Path of the Skies (Skyreach)
    [1254557] = { type = Type.Spell }, -- Path of the Crowning Pinnacle (Skyreach)
    [159902] = { type = Type.Spell }, -- Path of the Burning Mountain (Upper Blackrock Spire)
}
_A.TeleportsDungeonMistsOfPandaria = {
    [131225] = { type = Type.Spell }, -- Path of the Setting Sun (Gate of the Setting Sun)
    [131222] = { type = Type.Spell }, -- Path of the Mogu King (Mogu'shan Palace)
    [131232] = { type = Type.Spell }, -- Path of the Necromancer (Scholomance)
    [131231] = { type = Type.Spell }, -- Path of the Scarlet Blade (Scarlet Halls)
    [131229] = { type = Type.Spell }, -- Path of the Scarlet Mitre (Scarlet Monastery)
    [131228] = { type = Type.Spell }, -- Path of the Black Ox (Siege of Niuzao)
    [131206] = { type = Type.Spell }, -- Path of the Shado-Pan (Shado-Pan Monastery)
    [131205] = { type = Type.Spell }, -- Path of the Stout Brew (Stormstout Brewery)
    [131204] = { type = Type.Spell }, -- Path of the Jade Serpent (the Temple of the Jade Serpent)
}
_A.TeleportsDungeonCataclysm = {
    [445424] = { type = Type.Spell }, -- Path of the Twilight Fortress (Grim Batol)
    [424142] = { type = Type.Spell }, -- Path of the Tidehunter (Throne of the Tides)
    [410080] = { type = Type.Spell }, -- Path of Wind's Domain (The Vortex Pinnacle)
}
_A.TeleportsDungeonWrathOfTheLichKing = {
    [1254555] = { type = Type.Spell }, -- Path of Unyielding Blight Pit of Saron)
}

_A.TeleportsDungeon = {
    { expansion = "Midnight", dungeons = _A.TeleportsDungeonMidnight },
    { expansion = "The War Within", dungeons = _A.TeleportsDungeonTheWarWithin },
    { expansion = "Dragonflight", dungeons = _A.TeleportsDungeonDragonflight },
    { expansion = "Shadowlands", dungeons = _A.TeleportsDungeonShadowlands },
    { expansion = "Battle for Azeroth", dungeons = _A.TeleportsDungeonBattleForAzeroth },
    { expansion = "Legion", dungeons = _A.TeleportsDungeonLegion },
    { expansion = "Warlords of Draenor", dungeons = _A.TeleportsDungeonWarlordsOfDraenor },
    { expansion = "Pandaria", dungeons = _A.TeleportsDungeonMistsOfPandaria },
    { expansion = "Cataclysm", dungeons = _A.TeleportsDungeonCataclysm },
    { expansion = "Wrath of the Lich King", dungeons = _A.TeleportsDungeonWrathOfTheLichKing },
}

_A.TeleportDungeonLookup = {}
for _, teleports in ipairs(_A.TeleportsDungeon) do
    for id, data in pairs(teleports.dungeons) do
        _A.TeleportDungeonLookup[id] = data
    end
end

_A.TeleportsRaid = {
---- The War Within (11.0)
    [1226482] = { type = Type.Spell }, -- Path of the Full House (the Liberation of Undermine)
    [1239155] = { type = Type.Spell }, -- Path of the All-Devouring (Manaforge Omega)
---- Dragonflight (10.0)
    [432254] = { type = Type.Spell }, -- Path of the Primal Prison (the Vault of the Incarnates)
    [432257] = { type = Type.Spell }, -- Path of the Bitter Legacy (Aberrus, the Shadowed Crucible)
    [432258] = { type = Type.Spell }, -- Path of the Scorching Dream (Amirdrassil, the Dream's Hope)
---- Shadowlands (9.0)
    [373190] = { type = Type.Spell }, -- Path of the Sire (Castle Nathria)
    [373191] = { type = Type.Spell }, -- Path of the Tormented Soul (Sanctum of Domination)
    [373192] = { type = Type.Spell }, -- Path of the First Ones (Sepulcher of the First Ones)
}