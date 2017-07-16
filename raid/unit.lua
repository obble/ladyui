

    -- these were originally based on luna's raidframes
    -- credits to rhena

    local sb = [[Interface\AddOns\ladyui\art\statusbar.tga]]
    local bg = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local f  = CreateFrame'Frame'
    local xx = 4
    local bu = {}
    local a_offset, y_offset = 0, 0
    local roster = {
        [1] = {}, [2] = {}, [3] = {}, [4] = {},
        [5] = {}, [6] = {}, [7] = {}, [8] = {},
    }

    local cache = function(num)
        if num < 1 then
            for i = 1,  8 do _G['ladyraid_grp'..i]:Hide() end
            for i = 1, 40 do _G['ladyraid'..i]:Hide() end
        elseif RAID_SUBGROUP_LISTS then
            for i = 1,  8 do roster[i] = {} end
            for i = 1,  8 do
                for j = 1, 5 do
                    if RAID_SUBGROUP_LISTS[i][j] then
                        roster[i][j] = 'raid'..RAID_SUBGROUP_LISTS[i][j]
                    else
                        roster[i][j] = nil
                    end
				end
                table.sort(roster[i], function(a, b) return a < b end)
            end
        end
    end

    local format = function(index)
        for i = 1, 8 do
            local header = _G['ladyraid_grp'..i]
            if  getn(roster[i]) > 0 then
                header:Show() header.text:SetText(i)
            else
                header:Hide()
            end
            for j, v in pairs(roster[i]) do
                local raid = bu[index]
                raid.unit = v
                if raid.unit then
                    raid:Show()
                end
                index = index + 1
            end
        end
        for i = index, 40 do bu[index]:Hide() end
    end

    local arrange = function(index)
        for i = 1, 8 do
            local header = _G['ladyraid_grp'..i]
            for j = 1, getn(roster[i]) do
                local raid = bu[index]
                if j == 1 then
                    raid:ClearAllPoints()
                    raid:SetPoint('TOP', header, 'BOTTOM', 0, -10)
                else
                    raid:ClearAllPoints()
                    raid:SetPoint('TOP', bu[index - 1], 'BOTTOM', 0, -5)
                end
                index = index + 1
            end
        end
    end

    local rosterupdate = function()
        local index = 1
        cache(GetNumRaidMembers())
        format(index)
        arrange(index)
    end

    local raidicon = function(bu)
        bu.ric:Hide() bu.name:Show()
        if UnitExists(bu.unit) then
            local i = GetRaidTargetIndex(bu.unit)
            if i then
                SetRaidTargetIconTexture(bu.ric, i)
                bu.ric:Show() bu.name:Hide()
            end
        end
    end

    local status = function(bu)
        bu.name:SetShadowColor(0, 0, 0)
        if not UnitIsConnected(this.unit) then
            bu.hp:SetStatusBarColor(.7, .7, .7)
            bu.hp:SetMinMaxValues(0, 1)
            bu.hp:SetValue(1)
            bu.name:SetTextColor(.1, .1, .1)
        elseif UnitIsDead(this.unit) then
            bu.name:SetTextColor(1, 0, 0)
        elseif UnitIsGhost(this.unit) then
            bu.name:SetShadowColor(.15, .15, .15)
            bu.name:SetTextColor(.5, .5, .5)
        else
            local _, class = UnitClass(this.unit)
            local colour   = class and RAID_CLASS_COLORS[class] or {r = .2, g = .2, b = .2}
            bu.hp:SetStatusBarColor(colour.r, colour.g, colour.b)
            bu.name:SetTextColor(colour.r, colour.g, colour.b)
        end
    end

    local raidupdate = function()
        if this:IsShown() then
            if not UnitExists(this.unit) then this:Hide() return end
            local now            = GetTime()
            local hp, name = this.hp, this.name
            local power          = UnitPowerType(this.unit)
            local r, g, b        = name:GetTextColor()

            hp:SetMinMaxValues(0, UnitHealthMax(this.unit))
            hp:SetValue(UnitHealth(this.unit))

            name:SetText(string.sub(UnitName(this.unit), 1, 6))

            raidicon(this)
            status(this)
        end
    end

    local display = function(t, y, a)
        Minimap.raid:Show()
        local time = GetTime()
        if  a + a_offset < a + .6 then
            a = a + a_offset
            a_offset = a_offset + .005
            Minimap.raid:SetAlpha(a)
        end
        if  y + y_offset < y + 12 then
            y = y + y_offset
            y_offset = y_offset + 2
            Minimap.raid:SetPoint('TOP', Minimap, 'BOTTOM', 2, -y)
        end
        if Minimap.raid:GetAlpha() == 1 and y_offset == 12 then this:SetScript('OnUpdate', nil) end
    end


    local ToggleTank = function(unit)
        if  this.tank:IsShown() then
            this.tank:Hide()
        else
            this.tank:Show()
        end
    end

    local CreateUnits = function()
        for i = 1, 8 do
            local header = CreateFrame('Button', 'ladyraid_grp'..i, UIParent)
            header:SetWidth(32) header:SetHeight(12)
            header:SetMovable(true) header:SetUserPlaced(true)
            header:RegisterForDrag'LeftButton' header:EnableMouse(true)
            header:Hide()

            header.text = header:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
            header.text:SetPoint('LEFT', header)
            header.text:SetJustifyH'CENTER'
            header.text:SetText'group'

            if i == 1 then
                header:SetPoint('TOPLEFT', PlayerFrame, 'BOTTOMLEFT', 80, -30)
            else
                header:SetPoint('TOPLEFT',  _G['ladyraid_grp'..(i - 1)], 'BOTTOMLEFT', 0, -90)
            end

            header:SetScript('OnDragStart', function() this:StartMoving() end)
            header:SetScript('OnDragStop',  function() this:StopMovingOrSizing() end)
        end

        for i = 1, 40 do
            bu[i] = CreateFrame('Button', 'ladyraid'..i, UIParent)
            bu[i]:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
            bu[i]:SetWidth(100)
            bu[i]:SetHeight(14)
    		bu[i]:SetResizable(true)
            bu[i]:SetBackdrop(bg)
            bu[i]:SetBackdropColor(0, 0, 0, 1)
            bu[i]:SetFrameLevel(0)
            bu[i]:Hide()

            bu[i].hp = CreateFrame('StatusBar', nil, bu[i])
            bu[i].hp:SetFrameLevel(1)
            bu[i].hp:SetMinMaxValues(0, 100)
            bu[i].hp:SetValue(100)
            bu[i].hp:SetStatusBarTexture(sb)
            bu[i].hp:SetStatusBarColor(0, 1, 0)
            bu[i].hp:SetPoint('TOPLEFT', bu[i], 2, -2)
            bu[i].hp:SetPoint('BOTTOMRIGHT', bu[i], -2, 2)
            table.insert(barstosmooth, bu[i].hp)

            bu[i].bd = CreateFrame('StatusBar', nil, bu[i])
            bu[i].bd:SetFrameLevel(0)
            bu[i].bd:SetMinMaxValues(0, 100)
            bu[i].bd:SetValue(100)
            bu[i].bd:SetStatusBarTexture(sb)
            bu[i].bd:SetStatusBarColor(.2, .2, .2)
            bu[i].bd:SetAllPoints(bu[i].hp)

            bu[i].name = bu[i]:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
            bu[i].name:SetPoint('LEFT', bu[i], 'RIGHT', 5, 0)
            bu[i].name:SetJustifyH'CENTER'

            bu[i].ric = bu[i]:CreateTexture(nil, 'OVERLAY')
            bu[i].ric:SetWidth(17) bu[i].ric:SetHeight(17)
            bu[i].ric:SetTexture[[Interface\TargetingFrame\UI-RaidTargetingIcons]]
            bu[i].ric:SetPoint('CENTER', bu[i])

            bu[i].tank = bu[i].hp:CreateTexture(nil, 'OVERLAY', nil, 7)
            bu[i].tank:SetWidth(16) bu[i].tank:SetHeight(16)
            bu[i].tank:SetTexture[[Interface\AddOns\ladyui\raid\texture\Tank.tga]]
            bu[i].tank:SetPoint('CENTER', bu[i], 'BOTTOM', 0, 1)
            bu[i].tank:Hide()

            bu[i]:SetScript('OnClick',  function()
                if  arg1 == 'RightButton' then
                    ToggleTank(this.unit)
                else
                    if  CursorHasItem() then
                        DropItemOnUnit(this.unit)
                    elseif SpellIsTargeting() then
                        SpellTargetUnit(this.unit)
                    else
                        TargetUnit(this.unit)
                    end
                end
            end)
            bu[i]:SetScript('OnEnter',  function() UnitFrame_OnEnter() GameTooltipStatusBar:Hide() end)
            bu[i]:SetScript('OnLeave',  UnitFrame_OnLeave)
            bu[i]:SetScript('OnUpdate', raidupdate)
        end
    end

    Minimap.raid = CreateFrame('Button', 'ladyMinimap_RaidSpawn', Minimap)
    Minimap.raid:SetWidth(20) Minimap.raid:SetHeight(100)
    Minimap.raid:SetPoint('TOP', Minimap, 'BOTTOM')
    Minimap.raid:Hide()

    Minimap.raid.text = Minimap.raid:CreateFontString(nil, 'OVERLAY')
    Minimap.raid.text:SetFont(STANDARD_TEXT_FONT, 24, 'OUTLINE')
    Minimap.raid.text:SetPoint('CENTER', Minimap.raid)
    Minimap.raid.text:SetText'+'
    Minimap.raid.text:SetTextColor(0, 1, 0)

    Minimap.raid:SetScript('OnEnter', function()
        GameTooltip:SetOwner(this, 'ANCHOR_TOPRIGHT', -30, -60)
        GameTooltip:SetText'Click to show/hide Raid Frames'
        Minimap.raid.text:SetTextColor(1, 1, 0)
        GameTooltip:Show()
    end)

    Minimap.raid:SetScript('OnLeave', function()
        Minimap.raid.text:SetTextColor(0, 1, 0)
        GameTooltip:Hide()
    end)

    Minimap.raid:SetScript('OnClick', function()
        local t = this.text:GetText()
        if t == '+' then
            this.text:SetText'–'
            rosterupdate()
        elseif t == '–' then
            this.text:SetText'+'
            for i = 1,  8 do _G['ladyraid_grp'..i]:Hide() end
            for i = 1, 40 do bu[i]:Hide() end
        end
    end)

    f:RegisterEvent'VARIABLES_LOADED'
    f:RegisterEvent'PLAYER_LOGIN'
    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:RegisterEvent'CHAT_MSG_SYSTEM'  f:RegisterEvent'RAID_ROSTER_UPDATE'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:SetScript('OnEvent', function()
        if event == 'PLAYER_LOGIN' then
            CreateUnits()
        elseif (event == 'PLAYER_ENTERING_WORLD' and UnitInRaid'player')
        or (event == 'CHAT_MSG_SYSTEM' and string.find(arg1, 'You have joined a raid group')) then
            local t = GetTime() + 60
            local y = -20
            local a = .5
            Minimap.raid.text:SetText'+'
            f.reset = true
            f:SetScript('OnUpdate', function() display(t, y, a) end)
            f:UnregisterEvent'PLAYER_ENTERING_WORLD'
        elseif event == 'RAID_ROSTER_UPDATE' then
            if Minimap.raid.text:GetText() == '–' then rosterupdate() end
            if GetNumRaidMembers() < 1 or not UnitInRaid'player' then
                for i = 1, 8 do _G['ladyraid_grp'..i]:Hide() end
                Minimap.raid:Hide() f.reset = true
            end
        end
    end)


    --
