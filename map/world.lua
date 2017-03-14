

    UIPanelWindows['WorldMapFrame'] = {area = 'center', pushable = 9}

    local coord = CreateFrame('Frame', nil, WorldMapButton)

    local player = coord:CreateFontString(nil, 'OVERLAY')
    player:SetFont(STANDARD_TEXT_FONT, 18, 'OUTLINE')
    player:SetShadowOffset(0, -0)
    player:SetJustifyH'LEFT'
    player:SetPoint('BOTTOMRIGHT', WorldMapButton, 'BOTTOM', -12, 12)
    player:SetTextColor(1, 1, 1)

    local cursor = coord:CreateFontString(nil, 'OVERLAY')
    cursor:SetFont(STANDARD_TEXT_FONT, 18, 'OUTLINE')
    cursor:SetShadowOffset(0, -0)
    cursor:SetJustifyH'LEFT'
    cursor:SetPoint('LEFT', player, 'RIGHT', 3, 0)
    cursor:SetTextColor(1, 1, 1)

    coord:SetScript('OnUpdate', function(self, elapsed)
        local width  = WorldMapDetailFrame:GetWidth()
        local height = WorldMapDetailFrame:GetHeight()
        local mx, my = WorldMapDetailFrame:GetCenter()
        local px, py = GetPlayerMapPosition'player'
        local cx, cy = GetCursorPosition()

        mx = ((cx/WorldMapDetailFrame:GetEffectiveScale()) - (mx - width/2))/width
        my = ((my + height/2) - (cy/WorldMapDetailFrame:GetEffectiveScale()))/height

        if mx >= 0 and my >= 0 and mx <= 1 and my <= 1 then
            cursor:SetText('•  Mouse'..format(': %.0f / %.0f', mx*100, my*100))
        else
            cursor:SetText''
        end

        if px ~= 0 and py ~= 0 then
            player:SetText(PLAYER..format(': %.0f / %.0f', px*100, py*100))
        else
            player:SetText'X / X'
        end
    end)

        -- BLIPS
    local groupSize, groupType, frame
    local _, subgroup, class, color

    local blipColour = function(icon, unit)
        if not (icon and unit) then return end
        local _, name = UnitClass(unit)
        if not name then return end

        if string.find(unit, 'raid', 1, true) then         -- RAID GROUPS
            local _, _, subgroup = GetRaidRosterInfo(string.sub(unit, 5))
            if not subgroup then return end
            icon:SetTexture(string.format([[Interface\AddOns\ladyui\map\blips\raid]]..'%d', subgroup))
            icon:GetParent():SetWidth(30)
            icon:GetParent():SetHeight(30)
        end

        local t = RAID_CLASS_COLORS[name]
        if math.ceil(GetTime()) < .5 then
            if UnitAffectingCombat(unit) then       bu:SetVertexColor(.8, 0, 0)
            elseif MapUnit_IsInactive(unit) then    bu:SetVertexColor(1, .8, 0)
            elseif UnitIsDeadOrGhost(unit) then     bu:SetVertexColor(.2, .2, .2)
            end
        elseif t then
             icon:SetVertexColor(t.r, t.g, t.b)
        else icon:SetVertexColor(.8, .8, .8)
        end
    end

    local blipUpdate = function()
        local name = this:GetName()..'Icon'
        local texture = _G[name]
        if texture then modColour(texture, this.unit) end
    end

    local addUnit = function(unit, state, isNormal)
        local f = _G[unit]
        local icon = _G[unit..'Icon']
        if  state then
            f:SetScript('OnUpdate', modUpdate)
            if isNormal then
                icon:SetTexture[[Interface\AddOns\ladyui\map\blips\party]]
                icon:GetParent():SetWidth(30)
                icon:GetParent():SetHeight(30)
            end
        else
            f:SetScript('OnUpdate', function() MapUnit_OnUpdate(f) blipUpdate(f) end)
            icon:SetTexture[[Interface\WorldMap\WorldMapPartyIcon]]
        end
    end

    for i = 1, 4 do addUnit(string.format('WorldMapParty%d', i), true, true) end
    for i = 1,40 do addUnit(string.format('WorldMapRaid%d', i), true) end

    WorldMapFrame:SetScript('OnShow', function(self)
        self:SetScale(.8) self:EnableKeyboard(false)
        BlackoutWorld:Hide()
        UpdateMicroButtons()
        SetMapToCurrentZone()
        PlaySound'igQuestLogOpen'
        CloseDropDownMenus()
        WorldMapFrame_PingPlayerPosition()
    end)

    --
