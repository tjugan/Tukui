
local E, C, L, DB = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales


--------------------------------------------------------------------
 -- BAGS
--------------------------------------------------------------------

if DB["datatext"].bags and DB["datatext"].bags > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)

	local Text  = ElvuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(DB["media"].font_, DB["datatext"].fontsize, "THINOUTLINE")
	Text:SetShadowOffset(E.mult, -E.mult)
	Text:SetShadowColor(0, 0, 0, 0.4)
	E.PP(DB["datatext"].bags, Text)

	local function OnEvent(self, event, ...)
		local free, total,used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
		Text:SetText(L.datatext_bags..E.ValColor..used.."|r/"..E.ValColor..total)
		self:SetAllPoints(Text)
	end
          
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("BAG_UPDATE")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() OpenAllBags() end)
end