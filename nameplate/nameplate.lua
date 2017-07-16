

    local TEXTURE        = [[Interface\AddOns\ladyui\art\statusbar.tga]]
    local BACKDROP       = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]}

    local classes       = {}
    local events        = {'UPDATE_MOUSEOVER_UNIT', 'PLAYER_TARGET_CHANGED', 'UPDATE_BATTLEFIELD_SCORE'}
    local n, throttle   = 0, 0
    local  e = CreateFrame'Frame'

    local UpdateBar = function(self)
    	local min, max = self:GetMinMaxValues()
        local r, g, b  = self:GetStatusBarColor()
    	self.Clone:SetMinMaxValues(min, max)
    	self.Clone:SetValue(self:GetValue())
        self.Clone:SetStatusBarColor(r, g, b)
    	self.Clone:Show()
    end


    local HideBar = function(self)
    	self.Clone:Hide()
    end

    local CreateStatusBar = function(self, proto, width, height, offset)
        local r, g, b  = proto:GetStatusBarColor()

    	local Bar = CreateFrame('StatusBar', nil, self)
    	Bar:SetWidth(width)
        Bar:SetHeight(height)
    	Bar:SetStatusBarTexture(TEXTURE)
        Bar:SetStatusBarColor(r, g, b)

    	local Backdrop = Bar:CreateTexture(nil, 'BACKGROUND')
    	Backdrop:SetPoint('BOTTOMLEFT', -offset, -offset)
    	Backdrop:SetPoint('TOPRIGHT', offset, offset)
    	Backdrop:SetTexture(0, 0, 0)

    	local Background = Bar:CreateTexture(nil, 'BORDER')
    	Background:SetAllPoints()
    	Background:SetTexture(.5/3, .5/3, .5/3)
        Bar.Background = Background

    	local Name = Bar:CreateFontString(nil, 'OVERLAY')
        Name:SetFont(STANDARD_TEXT_FONT, 12)
    	Name:SetPoint('BOTTOMLEFT', Bar, 'TOPLEFT', -14, 8)
        Name:SetJustifyH'LEFT'
    	Bar.Name = Name

    	proto.Clone = Bar
    	proto:SetScript('OnValueChanged', UpdateBar)
    	proto:SetScript('OnShow', UpdateBar)
    	proto:SetScript('OnHide', HideBar)

    	return Bar
    end

    local CreatePlate = function(plate)
        local offset = (UIParent:GetScale()/plate:GetEffectiveScale()) + 2
        local health, cast = plate:GetChildren()
        local border, castborder, casticon, highlight, name, level, bossicon, raidicon = plate:GetRegions()

        local Health = CreateStatusBar(plate, health, 100, 8, offset)
        Health:SetPoint('BOTTOM', 0, 8)
        table.insert(barstosmooth, Health)

        local Cast = CreateStatusBar(plate, cast, 100, 8, offset)
    	Cast:SetPoint('TOPLEFT', Health, 'BOTTOMLEFT', 0, -offset)
    	Cast:Hide()

        name:SetFont(STANDARD_TEXT_FONT, 10)
        name:ClearAllPoints()
        name:SetPoint('BOTTOMLEFT', Health, 'TOPLEFT', -1, 7)

        level:SetFont(STANDARD_TEXT_FONT, 10)
        level:SetPoint('BOTTOMRIGHT', Health, 'TOPRIGHT', 1, 6) -- lol
        level:SetJustifyH'RIGHT'

        highlight:SetTexture''

        for _, v in pairs({health, cast}) do v:SetScale(.0001) end
        for _, v in pairs({border}) do v:Hide() end

        do
            plate.Name         = name
    		plate.Boss         = bossicon
    		plate.Level        = level
    		plate.ProtoHealth  = health
    		plate.Health       = Health
    		plate.totalElapsed = 0
        end

        -- ProtoCast:HookScript('OnShow', UpdateCast)
    end

    e:SetScript('OnUpdate', function(self, elapsed)
        throttle = throttle + elapsed
        local j = WorldFrame.GetNumChildren(WorldFrame)
        if j ~= n then
            for i = n + 1, j do
                local plate     = select(i, WorldFrame.GetChildren(WorldFrame))
                local region    = select(2, plate:GetRegions())
                if  region and region:GetObjectType() == 'Texture' and region:GetTexture() == [[Interface\Tooltips\Nameplate-Border]] then
                    if not plate.created then CreatePlate(plate) end
                end
            end
            n = j
        end
        if  throttle > 15 then
            throttle = 0
            if MiniMapBattlefieldFrame.status == 'active' then RequestBattlefieldScoreData() end
        end
    end)

    local AddName = function(name, class)
        if not class or not name then return end
        if class == 'UNKNOWN' or not RAID_CLASS_COLORS[class] then return end
        classes[name] = class
    end

    local function OnEvent(self, event, ...)
    	if self[event] then self[event]() end
    end

    function e:UPDATE_MOUSEOVER_UNIT()
    	if  UnitIsPlayer'mouseover' then
    		AddName(UnitName'mouseover', UnitClass'mouseover')
    	end
    end

    function e:PLAYER_TARGET_CHANGED()
    	if  UnitIsPlayer'target' then
    		AddName(UnitName'target', UnitClass'target')
    	end
    end

    function e:UPDATE_BATTLEFIELD_SCORE()
    	for i = 1, GetNumBattlefieldScores() do
    		local name, _, _, _, _, _, _, _, _, class = GetBattlefieldScore(i)
    		name = strsplit('-', name, 2)
    		AddName(name, class)
    	end
    end

    for _, v in pairs(events) do e:RegisterEvent(v) end
    e:SetScript('OnEvent', OnEvent)

    --
