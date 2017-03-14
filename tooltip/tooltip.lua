

    local tooltips = {
        'GameTooltip',
        'ShoppingTooltip1',
        'ShoppingTooltip2',
        'SmallTextTooltip',
        'WorldMapTooltip',
        'ItemRefTooltip'
    }

    for _, v in next, tooltips do
        local f = _G[v]
        f:SetBackdrop(
            {bgFile = [[Interface\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-BACKGROUND]],}
        )
        f:SetBackdropColor(0, 0, 0)
        for i = 1, 10 do
            for _, v in pairs(
                {
                    _G['GameTooltipTextLeft'..i], _G['GameTooltipTextRight'..i],
                    _G['ItemRefTooltipTextLeft'..i], _G['ItemRefTooltipTextRight'..i]
                }
            ) do
                v:SetFont(STANDARD_TEXT_FONT, i == 1 and 13 or 11, 'OUTLINE')
                v:SetShadowOffset(0, 0)
            end
        end
    end

    local GetMouseoverUnit = function()
        local _, unit = GameTooltip:GetUnit()
        if not unit or not UnitExists(unit) or UnitIsUnit(unit, 'mouseover') then
            return true
        else
            return false
        end
    end

    local UnitColors = function(unit)
    	if  UnitIsPlayer(unit) then
    		local _, class = UnitClass(unit)
    		return RAID_CLASS_COLORS[class]
    	else
    		return FACTION_BAR_COLORS[UnitReaction(unit, 'player')]
    	end
    end

    local addStatusBarColor = function(bar, unit)
        local colour = UnitColors(unit)
        bar:SetStatusBarColor(colour.r, colour.g, colour.b)
    end

    local addStatusBar = function(tooltip)
        GameTooltipStatusBar:SetStatusBarTexture[[Interface\AddOns\ladyui\art\statusbar.tga]]
        GameTooltipStatusBar:ClearAllPoints()
        GameTooltipStatusBar:SetPoint('TOPLEFT',  0, -2)
        GameTooltipStatusBar:SetPoint('TOPRIGHT', 0, -2)
        GameTooltipStatusBar:SetHeight(15)
        GameTooltipStatusBar:SetFrameLevel(0)
        GameTooltipStatusBar:SetBackdrop(
            {bgFile = [[Interface\Buttons\WHITE8x8]],
            insets = {
               left     =  0,
               right    =  0,
               top      = -1,
               bottom   = -2,
                }
            }
        )
        GameTooltipStatusBar:SetBackdropColor(0, 0, 0)
    end

    local addAnchor = function(tooltip, parent)
        if  not GetMouseoverUnit() then
            tooltip:SetOwner(parent, 'ANCHOR_CURSOR')
        else
            addStatusBar(tooltip)
            tooltip:ClearAllPoints()
            tooltip:SetPoint('BOTTOMRIGHT', UIParent, -25, 25)
            if  ContainerFrame1:IsShown() then
                tooltip:SetAnchorType'ANCHOR_CURSOR'
            end
        end
    end

    GameTooltip:HookScript('OnTooltipSetUnit', function(self)
        local _, unit = self:GetUnit()
        addStatusBarColor(GameTooltipStatusBar, unit)
    end)

    hooksecurefunc('GameTooltip_SetDefaultAnchor', addAnchor)
