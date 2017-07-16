

    local _, class  = UnitClass'player'
    local hover     = {}

    local zoom = function()
        if not arg1 then return end
        if arg1 > 0 and Minimap:GetZoom() < 5 then
            Minimap:SetZoom(Minimap:GetZoom() + 1)
        elseif arg1 < 0 and Minimap:GetZoom() > 0 then
            Minimap:SetZoom(Minimap:GetZoom() - 1)
        end
    end

    local f = CreateFrame('Frame', nil, Minimap)
    f:EnableMouse(false)
    f:SetPoint('TOPLEFT', Minimap)
    f:SetPoint('BOTTOMRIGHT', Minimap)
    f:EnableMouseWheel(true)
    f:SetScript('OnMouseWheel', zoom)

    for _, v in pairs({
        MinimapBorderTop,
        MinimapToggleButton,
        MinimapZoomIn,
	    MinimapZoomOut
    }) do
        v:Hide()
    end

    MiniMapTracking:SetScale(.79)
    MiniMapTracking:SetFrameStrata'MEDIUM'
    MiniMapTracking:ClearAllPoints()
    MiniMapTracking:SetPoint('RIGHT', -40, 102)

    MiniMapMailFrame:ClearAllPoints()
    MiniMapMailFrame:SetPoint('TOPRIGHT', 0, -10)

    MinimapZoneText:ClearAllPoints()
    MinimapZoneText:SetPoint('TOP', Minimap, 0, 20)

    MiniMapWorldMapButton:ClearAllPoints()
    MiniMapWorldMapButton:SetPoint('RIGHT', -2, 30)

    GameTimeFrame:SetScale(.8)
    GameTimeFrame:ClearAllPoints()
    GameTimeFrame:SetPoint('RIGHT', 8, 42)

    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if  arg1 == 'Blizzard_TimeManager' then
            local border    = TimeManagerClockButton:GetRegions()
            local colour    = RAID_CLASS_COLORS[class]

            border:Hide()

            TimeManagerClockButton:ClearAllPoints()
            TimeManagerClockButton:SetPoint('BOTTOM', Minimap, 0, -28)

            TimeManagerClockTicker:SetFont(STANDARD_TEXT_FONT, 14)
            TimeManagerClockTicker:SetTextColor(colour.r, colour.g, colour.b)

            f:UnregisterAllEvents()
        end
    end)

    --
