local E = unpack(ElvUI)

--Lua functions
local format = format

function mMT:DebugPrintTable(tbl)
	mMT:Print(": Table Start >>>")
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			print(k, v)
		end
	else
		mMT:Print("Not a Table:", tbl)
	end
end

function mMT:ColorCheck(value)
	if value >= 1 then
		return 1
	elseif value <= 1 then
		return 0
	else
		return value
	end
end

function mMT:ColorFade(colorA, colorB, percent)
	local color = {}
	if colorA and colorA.r and colorA.g and colorA.b and colorB and colorB.r and colorB.g and colorB.b and percent then
		color.r = colorA.r - (colorA.r - colorB.r) * percent
		color.g = colorA.g - (colorA.g - colorB.g) * percent
		color.b = colorA.b - (colorA.b - colorB.b) * percent
		color.color = E:RGBToHex(color.r, color.g, color.b)
		return color
	elseif colorA and colorA.r and colorA.g and colorA.b then
		return colorA
	else
		print("|CFFE74C3CERROR - mMediaTag - COLORFADE|r")
		return nil
	end
end

function mMT:Check_ElvUI_EltreumUI()
	return (IsAddOnLoaded("ElvUI_EltreumUI") and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable)
end
function mMT:mIcon(icon, x, y)
	if icon then
		return format("|T%s:%s:%s:0:0:64:64:4:60:4:60|t", icon, x or 16, y or 16)
	end
end

function mMT:mCurrencyLink(id)
	return format("|cffffffff|Hcurrency:%s|h|r", id)
end

function mMT:round(number, decimals)
	if number then
		return (("%%.%df"):format(decimals)):format(number)
	else
		mMT:Print(L["!! ERROR - Round:"] .. " " .. number .. " - " .. decimals)
		return 0
	end
end

function mMT:IsNumber(number)
	if tonumber(number) then
		return true
	else
		return false
	end
end

function mMT:Print(...)
	print(mMT.Name .. ":", ...)
end

function mMT:GetClassColor(unit)
	if UnitIsPlayer(unit) then
		local _, unitClass = UnitClass(unit)
		local cs = E.oUF.colors.class[unitClass]
		return (cs and E:RGBToHex(cs.r, cs.g, cs.b)) or "|cFFcccccc"
	end
end

function mMT:SetElvUIMediaColor()
	local color = E:ClassColor(E.myclass)
	E.db.general.valuecolor["r"] = color.r
	E.db.general.valuecolor["g"] = color.g
	E.db.general.valuecolor["b"] = color.b
	E.db.general.valuecolor["a"] = 1
	E:UpdateAll()
end
