local E, L = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

--Lua functions
local tinsert = tinsert
local format = format
local wipe = wipe
local pairs = pairs
local math = math
local string = string
local select = select

--WoW API / Variables
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local GetSpellTexture = GetSpellTexture
local GetSpellInfo = GetSpellInfo
local IsSpellKnown = IsSpellKnown
local GetItemIcon = GetItemIcon
local GetItemInfo = GetItemInfo
local GetItemCount = GetItemCount
local PlayerHasToy = PlayerHasToy
local C_ToyBox = C_ToyBox
local GetSpellCooldown = GetSpellCooldown
local GetItemCooldown = GetItemCooldown
local GetTime = GetTime
local GetProfessions = GetProfessions
local GetProfessionInfo = GetProfessionInfo

--Variables
local mText = L["Teleports"]
local menuFrame = CreateFrame("Frame", "mMediaTag_Teleports_Menu", E.UIParent, "BackdropTemplate")
menuFrame:SetTemplate("Transparent", true)

local Teleports = {
	toys = {
		available = false,
		tps = {
			[110560] = true, --garrison-hearthstone
			[140192] = true, --dalaran-hearthstone
			[162973] = true, --greatfather-winters-hearthstone
			[163045] = true, --headless-horsemans-hearthstone
			[165669] = true, --lunar-elders-hearthstone
			[165670] = true, --peddlefeets-lovely-hearthstone
			[165802] = true, --noble-gardeners-hearthstone
			[166746] = true, --fire-eaters-hearthstone
			[166747] = true, --brewfest-revelers-hearthstone
			[168907] = true, --holographic-digitalization-hearthstone
			[172179] = true, --eternal-travelers-hearthstone
			[180290] = true, --night-fae-hearthstone
			[182773] = true, --necrolord-hearthstone
			[184353] = true, --kyrian-hearthstone
			[188952] = true, --dominated-hearthstone
			[190196] = true, --enlightened-hearthstone
			[193588] = true, --Timewalker's Hearthstone
			[200630] = true, --ohnir-windsages-hearthstone
			[183716] = true, -- Venthyr Sinstone
			[208704] = true, -- Deepdweller's Earthen Hearthstone
		},
	},
	engineering = {
		available = false,
		tps = {
			[87215] = true, --wormhole-generator-pandaria
			[48933] = true, --wormhole-generator-northrend
			[198156] = true, -- Wyrmhole Generator
			[172924] = true, --wormhole-generator-shadowlands
			[168808] = true, --wormhole-generator-zandalar
			[168807] = true, --wormhole-generator-kultiras
			[151652] = true, --wormhole-generator-argus
			[112059] = true, --wormhole-centrifuge
		},
	},
	items = {
		available = false,
		tps = {
			[6948] = true, --hearthstone
			[17690] = true, --frostwolf-insignia-rank-1
			[17691] = true, --stormpike-insignia-rank-1
			[17900] = true, --stormpike-insignia-rank-2
			[17901] = true, --stormpike-insignia-rank-3
			[17902] = true, --stormpike-insignia-rank-4
			[17903] = true, --stormpike-insignia-rank-5
			[17904] = true, --stormpike-insignia-rank-6
			[17905] = true, --frostwolf-insignia-rank-2
			[17906] = true, --frostwolf-insignia-rank-3
			[17907] = true, --frostwolf-insignia-rank-4
			[17908] = true, --frostwolf-insignia-rank-5
			[17909] = true, --frostwolf-insignia-rank-6
			[18984] = true, --dimensional-ripper-everlook
			[18986] = true, --ultrasafe-transporter-gadgetzan
			[22589] = true, --atiesh-greatstaff-of-the-guardian
			[22630] = true, --atiesh-greatstaff-of-the-guardian
			[22631] = true, --atiesh-greatstaff-of-the-guardian
			[22632] = true, --atiesh-greatstaff-of-the-guardian
			[28585] = true, --ruby-slippers
			[29796] = true, --socrethars-teleportation-stone
			[30542] = true, --dimensional-ripper-area-52
			[30544] = true, --ultrasafe-transporter-toshleys-station
			[32757] = true, --blessed-medallion-of-karabor
			[35230] = true, --darnarians-scroll-of-teleportation
			[37118] = true, --scroll-of-recall
			[37863] = true, --direbrews-remote
			[40585] = true, --signet-of-the-kirin-tor
			[40586] = true, --band-of-the-kirin-tor
			[43824] = true, --the-schools-of-arcane-magic-mastery
			[44314] = true, --scroll-of-recall-ii
			[44315] = true, --scroll-of-recall-iii
			[44934] = true, --loop-of-the-kirin-tor
			[44935] = true, --ring-of-the-kirin-tor
			[45688] = true, --inscribed-band-of-the-kirin-tor
			[45689] = true, --inscribed-loop-of-the-kirin-tor
			[45690] = true, --inscribed-ring-of-the-kirin-tor
			[45691] = true, --inscribed-signet-of-the-kirin-tor
			[46874] = true, --argent-crusaders-tabard
			[48954] = true, --etched-band-of-the-kirin-tor
			[48955] = true, --etched-loop-of-the-kirin-tor
			[48956] = true, --etched-ring-of-the-kirin-tor
			[48957] = true, --etched-signet-of-the-kirin-tor
			[50287] = true, --boots-of-the-bay
			[51557] = true, --runed-signet-of-the-kirin-tor
			[51558] = true, --runed-loop-of-the-kirin-tor
			[51559] = true, --runed-ring-of-the-kirin-tor
			[51560] = true, --runed-band-of-the-kirin-tor
			[52251] = true, --jainas-locket
			[54452] = true, --ethereal-portal
			[58487] = true, --potion-of-deepholm
			[61379] = true, --gidwins-hearthstone
			[63206] = true, --wrap-of-unity
			[63207] = true, --wrap-of-unity
			[63352] = true, --shroud-of-cooperation
			[63353] = true, --shroud-of-cooperation
			[63378] = true, --hellscreams-reach-tabard
			[63379] = true, --baradins-wardens-tabard
			[64457] = true, --the-last-relic-of-argus
			[65274] = true, --cloak-of-coordination
			[65360] = true, --cloak-of-coordination
			[68808] = true, --heros-hearthstone
			[68809] = true, --veterans-hearthstone
			[92510] = true, --voljins-hearthstone
			[93672] = true, --dark-portal
			[95050] = true, --the-brassiest-knuckle
			[95051] = true, --the-brassiest-knuckle
			[95567] = true, --kirin-tor-beacon
			[95568] = true, --sunreaver-beacon
			[103678] = true, --time-lost-artifact
			[118663] = true, --relic-of-karabor
			[118907] = true, --pit-fighters-punching-ring
			[118908] = true, --pit-fighters-punching-ring
			[119183] = true, --scroll-of-risky-recall
			[128353] = true, --admirals-compass
			[128502] = true, --hunters-seeking-crystal
			[129276] = true, --beginners-guide-to-dimensional-rifting
			[138448] = true, --emblem-of-margoss
			[139590] = true, --scroll-of-teleport-ravenholdt
			[139599] = true, --empowered-ring-of-the-kirin-tor
			[141013] = true, --scroll-of-town-portal-shalanir
			[141014] = true, --scroll-of-town-portal-sashjtar
			[141015] = true, --scroll-of-town-portal-kaldelar
			[141016] = true, --scroll-of-town-portal-faronaar
			[141017] = true, --scroll-of-town-portal-liantril
			[141605] = true, --flight-masters-whistle
			[142298] = true, --astonishingly-scarlet-slippers
			[142469] = true, --violet-seal-of-the-grand-magus
			[142543] = true, --scroll-of-town-portal
			[144391] = true, --pugilists-powerful-punching-ring
			[151016] = true, --fractured-necrolyte-skull
			[180817] = true, --cypher-of-relocation
			[184871] = true, --dark-portal 2?
		},
	},
	spells = {
		available = false,
		tps = {
			[556] = true, --astral-recall
			[50977] = true, --death-gate
			[193759] = true, --teleport-hall-of-the-guardian
			[193753] = true, --dreamwalk
			[126892] = true, --zen-pilgrimage
		},
	},
	season = {
		available = false,
		tps = {
			-- S3
			[426121] = "DOTI", --teleport-dawn-of-the-infinite
			[424167] = "WM", --path-of-hearts-bane
			[424187] = "AD", --path-of-the-golden-tomb
			[424163] = "DH", --path-of-the-nightmare-lord
			[424153] = "BRH", --path-of-ancient-horrors
			[159901] = "EB", --path-of-the-verdant
			[424142] = "TOT", --path-of-the-tidehunter
		},
	},

	df = {
		available = false,
		tps = {
			[426121] = "DOTI", --teleport-dawn-of-the-infinite
			[393222] = "ULD", --path-of-the-watchers-legacy
			[393256] = "RLP", --pfad-des-nestverteidigers
			[393262] = "NO", --path-of-the-windswept-plains
			[393267] = "BH", --path-of-the-rotting-woods
			[393273] = "AA", --path-of-the-draconic-diploma
			[393276] = "NELT", --path-of-the-obsidian-hoard
			[393279] = "AV", --pfad-der-arkanen-geheimnisse
			[393283] = "HOI", --path-of-the-titanic-reservoir
		},
	},

	dungeonportals = {
		available = false,
		tps = {
			[131204] = true, --path-of-the-jade-serpent
			[131205] = true, --path-of-the-stout-brew
			[131206] = true, --path-of-the-shado-pan
			[131222] = true, --path-of-the-mogu-king
			[131225] = true, --path-of-the-setting-sun
			[131228] = true, --path-of-the-black-ox
			[131229] = true, --path-of-the-scarlet-mitre
			[131231] = true, --path-of-the-scarlet-blade
			[131232] = true, --path-of-the-necromancer
			[159895] = true, --path-of-the-bloodmaul
			[159896] = true, --path-of-the-iron-prow
			[159897] = true, --path-of-the-vigilant
			[159898] = true, --path-of-the-skies
			[159899] = true, --path-of-the-crescent-moon
			[159900] = true, --path-of-the-dark-rail
			[159901] = "EB", --path-of-the-verdant
			[159902] = true, --path-of-the-burning-mountain
			[354462] = true, --path-of-the-courageous
			[354463] = true, --path-of-the-plagued
			[354464] = true, --path-of-the-misty-forest
			[354465] = true, --path-of-the-sinful-soul
			[354467] = true, --path-of-the-undefeated
			[354468] = true, --path-of-the-scheming-loa
			[354469] = true, --path-of-the-stone-warden
			[367416] = true, --path-of-the-streetwise-merchant
			[373190] = true, --path-of-the-sire
			[373191] = true, --path-of-the-tormented-soul
			[373192] = true, --path-of-the-first-ones
			[373262] = true, --path-of-the-fallen-guardian
			[373274] = true, --path-of-the-scrappy-prince
			[426121] = "DOTI", --teleport-dawn-of-the-infinite
			[393222] = "ULD", --path-of-the-watchers-legacy
			[393256] = "RLP", --path-of-the-clutch-defender
			[393262] = "NO", --path-of-the-windswept-plains
			[393267] = "BH", --path-of-the-rotting-woods
			[393273] = "AA", --path-of-the-draconic-diploma
			[393276] = "NELT", --path-of-the-obsidian-hoard
			[393279] = "AV", --path-of-arcane-secrets
			[393283] = "HOI", --path-of-the-titanic-reservoir
			[393764] = true, --path-of-proven-worth
			[393766] = true, --path-of-the-grand-magistrix
			[410071] = "FH", -- path-of-the-freebooter
			[410074] = "UNDR", -- path-of-festering-rot
			[410078] = "NL", -- path-of-the-earth-warder
			[410080] = "VP", -- path-of-winds-domain
			[424167] = "WM", --path-of-hearts-bane
			[424187] = "AD", --path-of-the-golden-tomb
			[424163] = "DH", --path-of-the-nightmare-lord
			[424153] = "BRH", --path-of-ancient-horrors
			[424142] = "TOT", --path-of-the-tidehunter
		},
	},
	menu = {},
}

local function LeaveFunc(btn)
	GameTooltip:Hide()
end

local function mMenuAdd(tbl, text, time, macro, icon, tooltip, funcOnEnter)
	tinsert(tbl, {
		text = text,
		Secondtext = time,
		icon = icon,
		isTitle = false,
		tooltip = tooltip,
		macro = macro,
		funcOnEnter = funcOnEnter,
		funcOnLeave = LeaveFunc,
	})
end

local function mOnEnterItem(btn)
	GameTooltip:SetOwner(btn, "ANCHOR_CURSOR")
	GameTooltip:ClearLines()
	GameTooltip:SetItemByID(btn.tooltip)
	GameTooltip:Show()
end

local function mOnEnterSpell(btn)
	GameTooltip:SetOwner(btn, "ANCHOR_CURSOR")
	GameTooltip:ClearLines()
	GameTooltip:SetSpellByID(btn.tooltip)
	GameTooltip:Show()
end

local function mGetInfos(TeleportsTable, spell, tip, check)
	for i, v in pairs(TeleportsTable.tps) do
		local texture, name, hasSpell, hasItem = nil, nil, false, 0
		if spell then
			texture = GetSpellTexture(i)
			name = GetSpellInfo(i)
			hasSpell = IsSpellKnown(i)
		else
			texture = GetItemIcon(i)
			name = GetItemInfo(i)
			hasItem = GetItemCount(i)
		end

		local text1, text2 = nil, nil
		if (texture and name and (hasItem > 0 or (E.Retail and PlayerHasToy(i) and C_ToyBox.IsToyUsable(i)))) or (texture and name and hasSpell) then
			if check then
				TeleportsTable.available = true
			else
				local start, duration = nil, nil
				if spell then
					start, duration = GetSpellCooldown(i)
				else
					start, duration = GetItemCooldown(i)
				end
				local cooldown = start + duration - GetTime()

				if cooldown >= 2 then
					local hours = math.floor(cooldown / 3600)
					local minutes = math.floor(cooldown / 60)
					local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
					if hours >= 1 then
						minutes = math.floor(mod(cooldown, 3600) / 60)
						text1 = "|CFFDB3030" .. name .. "|r"
						text2 = "|CFFDB3030" .. hours .. "h " .. minutes .. "m|r"
					else
						text1 = "|CFFDB3030" .. name .. "|r"
						text2 = "|CFFDB3030" .. minutes .. "m " .. seconds .. "s|r"
					end
				elseif cooldown <= 0 then
					text1 = "|CFFFFFFFF" .. name .. "|r"
					text2 = "|CFF00FF00" .. L["Ready"] .. "|r"
				end

				if text1 and text2 then
					if type(v) == "string" then
						text1 = "[|CFF00AAFF" .. v .. "|r] " .. text1
					end

					if tip then
						DT.tooltip:AddDoubleLine(format("|T%s:14:14:0:0:64:64:5:59:5:59|t %s", texture, text1), text2)
					elseif spell then
						mMenuAdd(Teleports.menu, text1, text2, "/cast " .. name, texture, i, function(btn)
							mOnEnterSpell(btn)
						end)
					else
						mMenuAdd(Teleports.menu, text1, text2, "/use " .. name, texture, i, function(btn)
							mOnEnterItem(btn)
						end)
					end
				end
			end
		end
	end
end

local function EngineeringCheck()
	local prof1, prof2 = GetProfessions()
	if prof1 then
		prof1 = select(7, GetProfessionInfo(prof1))
	end

	if prof2 then
		prof2 = select(7, GetProfessionInfo(prof2))
	end

	return prof1 == 202 or prof2 == 202
end

local function CheckIfAvailable()
	mGetInfos(Teleports.toys, false, true, true)
	mGetInfos(Teleports.engineering, false, true, true)
	mGetInfos(Teleports.season, true, true, true)
	mGetInfos(Teleports.df, true, true, true)
	mGetInfos(Teleports.dungeonportals, true, true, true)
	mGetInfos(Teleports.items, false, true, true)
	mGetInfos(Teleports.spells, true, true, true)
end

local function mUpdateTPList(button)
	CheckIfAvailable()
	local _, _, _, _, _, title = mMT:mColorDatatext()

	wipe(Teleports.menu)
	if Teleports.toys.available and button == "LeftButton" then
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["Toys"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.toys, false, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
	end

	if EngineeringCheck() and Teleports.engineering.available and button == "RightButton" then
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["Engineering"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.engineering, false, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
	end

	if Teleports.season.available and button == "LeftButton" then
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["M+ Season"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.season, true, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
	end

	if Teleports.df.available and button == "LeftButton" then
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["DF Dungeons"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.df, true, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
	end

	if Teleports.dungeonportals.available and button == "MiddleButton" then
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["M+ Season"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.season, true, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })

		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["All Dungeon Teleports"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.dungeonportals, true, false, false)
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
	end

	if (Teleports.items.available or Teleports.spells.available) and button == "RightButton" then
		tinsert(Teleports.menu, { text = "", isTitle = true, notClickable = true })
		tinsert(Teleports.menu, { text = format("%s%s|r", title, L["Other"]), isTitle = true, notClickable = true })

		mGetInfos(Teleports.items, false, false, false)
		mGetInfos(Teleports.spells, true, false, false)
	end
end

local function OnClick(self, button)
	if not InCombatLockdown() then
		mUpdateTPList(button)
		mMT:mDropDown(Teleports.menu, menuFrame, self, 260, 2)
	end
end

local function mTPTooltip()
	CheckIfAvailable()
	if Teleports.toys.available then
		DT.tooltip:AddLine(L["Toys"])
		mGetInfos(Teleports.toys, false, true, false)
	end

	if EngineeringCheck() and Teleports.engineering.available then
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine(L["Engineering"])
		mGetInfos(Teleports.engineering, false, true, false)
	end

	if Teleports.season.available then
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine(L["M+ Season"])
		mGetInfos(Teleports.season, true, true, false)
	end

	if Teleports.df.available then
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine(L["DF Dungeons"])
		mGetInfos(Teleports.df, true, true, false)
	end

	if Teleports.items.available or Teleports.spells.available then
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine(L["Other"])
		mGetInfos(Teleports.items, false, true, false)
		mGetInfos(Teleports.spells, true, true, false)
	end
end

local function OnEnter(self)
	local nhc, hc, myth, mythp, other, titel, tip = mMT:mColorDatatext()
	DT.tooltip:ClearLines()
	mTPTooltip()
	DT.tooltip:AddLine(" ")
	DT.tooltip:AddLine(format("%s %s%s|r", mMT:mIcon(mMT.Media.Mouse["LEFT"]), tip, L["left click to open the small menu."]))
	DT.tooltip:AddLine(format("%s %s%s|r", mMT:mIcon(mMT.Media.Mouse["MIDDLE"]), tip, L["middle click to open the Dungeon Teleports menu."]))
	DT.tooltip:AddLine(format("%s %s%s|r", mMT:mIcon(mMT.Media.Mouse["RIGHT"]), tip, L["right click to open the other Teleports menu."]))
	DT.tooltip:Show()
end

local function OnEvent(self, event, unit)
	CheckIfAvailable()

	local hex = E:RGBToHex(E.db.general.valuecolor.r, E.db.general.valuecolor.g, E.db.general.valuecolor.b)
	local string = strjoin("", hex, "%s|r")

	if E.db.mMT.teleports.icon then
		self.text:SetFormattedText(string, format("|T%s:16:16:0:0:64:64|t %s", mMT.Media.TeleportIcons[E.db.mMT.teleports.customicon], mText))
	else
		self.text:SetFormattedText(string, mText)
	end
end

local function OnLeave(self)
	DT.tooltip:Hide()
end

DT:RegisterDatatext("mTeleports", "mMediaTag", nil, OnEvent, nil, OnClick, OnEnter, OnLeave, mText, nil, nil)
