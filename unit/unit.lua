

    local TEXTURE        = [[Interface\AddOns\ladyui\art\statusbar.tga]]
    local NAME           = [[Interface\AddOns\ladyui\art\name.tga]]
    local BACKDROP       = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]}
    local _, class       = UnitClass'player'
    local colour         = RAID_CLASS_COLORS[class]

    PlayerFrameBackground.bg = PlayerFrame:CreateTexture(nil, 'ARTWORK')
    PlayerFrameBackground.bg:SetPoint('TOPLEFT', PlayerFrameBackground)
    PlayerFrameBackground.bg:SetPoint('BOTTOMRIGHT', PlayerFrameBackground, 0, 22)
    PlayerFrameBackground.bg:SetVertexColor(colour.r, colour.g, colour.b, 1)
    PlayerFrameBackground.bg:SetTexture(NAME)
    PlayerFrameBackground.bg:SetTexCoord(1, 0, 0, 1)

    PlayerFrameHealthBar:SetBackdrop(BACKDROP)
    PlayerFrameHealthBar:SetBackdropColor(0, 0, 0, .6)
    PlayerFrameHealthBar:SetStatusBarTexture(TEXTURE)

    PlayerFrameManaBar:SetBackdrop(BACKDROP)
    PlayerFrameManaBar:SetBackdropColor(0, 0, 0, .6)
    PlayerFrameManaBar:SetStatusBarTexture(TEXTURE)

    TargetFrame.Elite = TargetFrameTextureFrame:CreateTexture(nil, 'BORDER')
    TargetFrame.Elite:SetTexture[[Interface\AddOns\ladtui\art\UI-TargetingFrame-Elite]]
    TargetFrame.Elite:SetWidth(128)
    TargetFrame.Elite:SetHeight(128)
    TargetFrame.Elite:SetPoint('TOPRIGHT', TargetFrame)
    TargetFrame.Elite:Hide()

    TargetFrame.Rare = TargetFrameTextureFrame:CreateTexture(nil, 'BORDER')
    TargetFrame.Rare:SetTexture[[Interface\AddOns\ladyui\art\UI-TargetingFrame-Rare-Elite]]
    TargetFrame.Rare:SetWidth(128)
    TargetFrame.Rare:SetHeight(128)
    TargetFrame.Rare:SetPoint('TOPRIGHT', TargetFrame)
    TargetFrame.Rare:Hide()

    TargetRaidTargetIcon:SetDrawLayer('OVERLAY', 7)

    TargetFrameNameBackground:SetTexture(NAME)
    TargetFrameNameBackground:SetDrawLayer'BORDER'

    TargetFrameHealthBar:SetBackdrop(BACKDROP)
    TargetFrameHealthBar:SetBackdropColor(0, 0, 0, .6)
    TargetFrameHealthBar:SetStatusBarTexture(TEXTURE)

    TargetFrameManaBar:SetBackdrop(BACKDROP)
    TargetFrameManaBar:SetBackdropColor(0, 0, 0, .6)
    TargetFrameManaBar:SetStatusBarTexture(TEXTURE)

    TargetLevelText:SetJustifyH'LEFT'
    TargetLevelText:SetPoint('LEFT', TargetFrameTextureFrame, 'CENTER', 56, -16)

    TargetofTargetHealthBar:SetStatusBarTexture(TEXTURE)

    TargetofTargetManaBar:SetStatusBarTexture(TEXTURE)

    for i = 1, 4 do
        for _, v in pairs({_G['PartyMemberFrame'..i..'HealthBar'], _G['PartyMemberFrame'..i..'ManaBar']}) do
            v:SetBackdrop(BACKDROP) v:SetBackdropColor(0, 0, 0, .6)
            v:SetStatusBarTexture(TEXTURE)
        end
    end

    local addPartyColor = function()              -- PARTY CLASS COLOUR
        for i = 1, MAX_PARTY_MEMBERS do
            local name = _G['PartyMemberFrame'..i..'Name']
            if UnitIsPlayer('party'..i) then
                local _, class = UnitClass('party'..i)
                local colour = RAID_CLASS_COLORS[class]
                if colour then name:SetTextColor(colour.r, colour.g, colour.b) end
            else
                name:SetTextColor(1, .8, 0)
            end
        end
    end

    function TargetFrame_CheckClassification()
        local c = UnitClassification'target'
        TargetFrameTexture:SetTexture[[Interface\TargetingFrame\UI-TargetingFrame]]
        for _, v in pairs({TargetFrame.Elite, TargetFrame.Rare}) do
            v:Hide()
        end
        if  c == 'worldboss' or c == 'rareelite' or c == 'elite' then
            TargetFrame.Elite:Show()
        elseif c == 'rare' then
            TargetFrame.Rare:Show()
        end
    end

    local t = CreateFrame'Frame'
    t:RegisterEvent'PLAYER_ENTERING_WORLD' t:RegisterEvent'PARTY_MEMBERS_CHANGED'
    t:RegisterEvent'PLAYER_TARGET_CHANGED' t:RegisterEvent'UNIT_FACTION'
    t:SetScript('OnEvent', function()           -- COLOUR UNIT
        if event == 'PLAYER_ENTERING_WORLD' or event == 'PARTY_MEMBERS_CHANGED' then
            addPartyColor()
        else
            local _, class = UnitClass'target'
            local colour = RAID_CLASS_COLORS[class]
            if  UnitIsPlayer'target' then
                TargetFrameNameBackground:SetVertexColor(colour.r, colour.g, colour.b, 1)
            end
        end
    end)

    hooksecurefunc('PartyMemberFrame_UpdateMember', addPartyColor)

    hooksecurefunc('TargetofTarget_Update', function()
        local _, class = UnitClass'targettarget'
        local colour = RAID_CLASS_COLORS[class]
        if  UnitIsPlayer'targettarget' then
            TargetofTargetName:SetTextColor(colour.r, colour.g, colour.b)
        else
            TargetofTargetName:SetTextColor(1, .8, 0)
        end
    end)

    --
