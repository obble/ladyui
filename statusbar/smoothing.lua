
    barstosmooth = {}   -- added in unit.lua, nameplate.lua, and here

    local smoothing = {}

    local bars = {      -- misc. shit that its not worth creating another .lua file for
        ReputationBar1, ReputationBar2, ReputationBar3, ReputationBar4, ReputationBar5,
        ReputationBar6, ReputationBar7, ReputationBar8, ReputationBar9, ReputationBar10,
        ReputationBar11, ReputationBar12, ReputationBar13, ReputationBar14, ReputationBar15,
        SkillRankFrame1, SkillRankFrame2, SkillRankFrame3, SkillRankFrame4,
        SkillRankFrame5, SkillRankFrame6, SkillRankFrame7, SkillRankFrame8,
        SkillRankFrame9, SkillRankFrame10, SkillRankFrame11, SkillRankFrame12,
    }

    table.insert(barstosmooth, bars)

    local smoothframe = CreateFrame'Frame'
    local min, max = math.min, math.max

    local AnimationTick = function()
        local limit = 30/GetFramerate()
        for bar, value in pairs(smoothing) do
            local cur = bar:GetValue()
            local new = cur + min((value - cur)/3, max(value - cur, limit))
            if new ~= new then new = value end
            if cur == value or abs(new - value) < 2 then
                bar:SetValue_(value)
                smoothing[bar] = nil
            else
                bar:SetValue_(new)
            end
        end
    end

    local SmoothSetValue = function(self, value)
        local _, max = self:GetMinMaxValues()

        if value == self:GetValue() or self._max and self._max ~= max then
            smoothing[self] = nil
            self:SetValue_(value)
        else
            smoothing[self] = value
        end

        self._max = max
    end

    for bar, value in pairs(smoothing) do
        if bar.SetValue_ then bar.SetValue = SmoothSetValue end
    end

    local SmoothBar = function(bar)
        if not bar.SetValue_ then
            bar.SetValue_ = bar.SetValue
            bar.SetValue  = SmoothSetValue
        end
    end

    local ResetBar = function(bar)
        if  bar.SetValue_ then
            bar.SetValue  = bar.SetValue_
            bar.SetValue_ = nil
        end
    end

    smoothframe:SetScript('OnUpdate', function()
        for _, v in pairs (barstosmooth) do
            if v then SmoothBar(v) end
        end
        AnimationTick()
    end)



    --
