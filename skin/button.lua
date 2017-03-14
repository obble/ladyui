

    -- just ls' border makin' code
    -- https://github.com/ls-/ls_UI/blob/master/core/border.lua

    local r, g, b   = .5, .5, .5
    local sections  = {'TOPLEFT', 'TOPRIGHT', 'BOTTOMLEFT', 'BOTTOMRIGHT', 'TOP', 'BOTTOM', 'LEFT', 'RIGHT'}
    local buttons   = {
        _G['ladymenu'],
        _G['MainMenuBarBackpackButton'],
        GameTooltip,
        ItemRefTooltip,
        ItemRefShoppingTooltip1,
        ItemRefShoppingTooltip2,
        ItemRefShoppingTooltip3,
        ShoppingTooltip1,
        ShoppingTooltip2,
        ShoppingTooltip3,
        WorldMapTooltip,
        WorldMapCompareTooltip1,
        WorldMapCompareTooltip2,
        WorldMapCompareTooltip3,
        FriendsTooltip,

        DropDownList1MenuBackdrop,
        DropDownList2MenuBackdrop,
        DropDownList3MenuBackdrop,
        ChatMenu,
        EmoteMenu,
        LanguageMenu,
    }

    local SetBorderColor = function(self, r, g, b, a)
    	local  t = self.borderTextures
    	if not t then return end
    	for  _, tex in pairs(t) do
    		tex:SetVertexColor(r or 1, g or 1, b or 1, a or 1)
    	end
    end

    local GetBorderColor = function(self)
    	return self.borderTextures and self.borderTextures.TOPLEFT:GetVertexColor()
    end

    local addBorder = function(object, offset)
    	if type(object) ~= 'table' or not object.CreateTexture or object.borderTextures then return end

    	local t = {}
    	offset = offset or 0

    	for i = 1, #sections do
    		local x = object:CreateTexture(nil, 'OVERLAY', nil, 1)
    		x:SetTexture('Interface\\AddOns\\ladyui\\art\\bu\\border-'..sections[i])
    		t[sections[i]] = x
    	end

    	t.TOPLEFT:SetWidth(8)
        t.TOPLEFT:SetHeight(8)
    	t.TOPLEFT:SetPoint('BOTTOMRIGHT', object, 'TOPLEFT', 4 + offset, -4 - offset)

    	t.TOPRIGHT:SetWidth(8)
        t.TOPRIGHT:SetHeight(8)
    	t.TOPRIGHT:SetPoint('BOTTOMLEFT', object, 'TOPRIGHT', -4 - offset, -4 - offset)

    	t.BOTTOMLEFT:SetWidth(8)
        t.BOTTOMLEFT:SetHeight(8)
    	t.BOTTOMLEFT:SetPoint('TOPRIGHT', object, 'BOTTOMLEFT', 4 + offset, 4 + offset)

    	t.BOTTOMRIGHT:SetWidth(8)
        t.BOTTOMRIGHT:SetHeight(8)
    	t.BOTTOMRIGHT:SetPoint('TOPLEFT', object, 'BOTTOMRIGHT', -4 - offset, 4 + offset)

    	t.TOP:SetHeight(8)
    	t.TOP:SetPoint('TOPLEFT', t.TOPLEFT, 'TOPRIGHT', 0, 0)
    	t.TOP:SetPoint('TOPRIGHT', t.TOPRIGHT, 'TOPLEFT', 0, 0)

    	t.BOTTOM:SetHeight(8)
    	t.BOTTOM:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'BOTTOMRIGHT', 0, 0)
    	t.BOTTOM:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'BOTTOMLEFT', 0, 0)

    	t.LEFT:SetWidth(8)
    	t.LEFT:SetPoint('TOPLEFT', t.TOPLEFT, 'BOTTOMLEFT', 0, 0)
    	t.LEFT:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'TOPLEFT', 0, 0)

    	t.RIGHT:SetWidth(8)
    	t.RIGHT:SetPoint('TOPRIGHT', t.TOPRIGHT, 'BOTTOMRIGHT', 0, 0)
    	t.RIGHT:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'TOPRIGHT', 0, 0)

    	object.borderTextures = t
    	object.SetBorderColor = SetBorderColor
    	object.GetBorderColor = GetBorderColor
    end

    for _, v in pairs(buttons) do
        addBorder(v)
        v:SetBorderColor(r, g, b)
    end

    for i = 1, 12 do
        for _, v in pairs({
            _G['ActionButton'..i],
            _G['MultiBarRightButton'..i],
            _G['MultiBarLeftButton'..i],
            _G['MultiBarBottomLeftButton'..i],
            _G['MultiBarBottomRightButton'..i],
            _G['BonusActionButton'..i],}) do
            addBorder(v, 1)
            v:SetBorderColor(r, g, b)
            v:GetPushedTexture():SetTexture''
            v:GetCheckedTexture():SetTexture''
        end

        for _, v in pairs({
            _G['MultiBarBottomLeftButton1'],
            _G['MultiBarBottomRightButton12'] }) do
            v:SetFrameStrata'LOW'
        end

        for _, v in pairs({
            _G['ActionButton'..i..'NormalTexture'],
            _G['MultiBarLeftButton'..i..'NormalTexture'],
            _G['MultiBarRightButton'..i..'NormalTexture'],
            _G['MultiBarBottomLeftButton'..i..'NormalTexture'],
            _G['MultiBarBottomRightButton'..i..'NormalTexture'],
            _G['BonusActionButton'..i..'NormalTexture'],}) do
            v:SetAlpha(0)
        end

        for _, v in pairs({
            _G['ActionButton'..i..'Cooldown'],
            _G['MultiBarLeftButton'..i..'Cooldown'],
            _G['MultiBarRightButton'..i..'Cooldown'],
            _G['MultiBarBottomLeftButton'..i..'Cooldown'],
            _G['MultiBarBottomRightButton'..i..'Cooldown'],}) do v:SetFrameLevel(4)
        end

        _G['BonusActionButton'..i..'Cooldown']:SetFrameLevel(6)
    end

    for i = 0, 3 do
        local bu = _G['CharacterBag'..i..'Slot']
        addBorder(bu)
        bu:SetBorderColor(r, g, b)
    end

    for i = 1, 2 do
        local bu = _G['TempEnchant'..i]
        local bo = _G['TempEnchant'..i..'Border']
        local du = _G['TempEnchant'..i..'Duration']
        bu:SetNormalTexture''
        bo:SetTexture''
        addBorder(bu, 1)
        bu:SetBorderColor(r, g, b)
        du:SetJustifyH'LEFT'
        du:ClearAllPoints() du:SetPoint('CENTER', bu, 'BOTTOM', 2, -9)
    end


    hooksecurefunc('BuffButton_Update', function()
        for i = 1, BUFF_MAX_DISPLAY do
            local bu = _G['BuffButton'..i]
            local du = _G['BuffButton'..i..'Duration']
            if  bu and not bu.borderTextures then
                bu:SetNormalTexture''
                addBorder(bu, 1)
                bu:SetBorderColor(r, g, b)
                du:ClearAllPoints() du:SetPoint('CENTER', bu, 'BOTTOM', 2, -9)
            end
        end

        for i = 1, DEBUFF_MAX_DISPLAY do
            local bu = _G['DebuffButton'..i]
            local du = _G['DebuffButton'..i..'Duration']
            if  bu and not bu.borderTextures then
                bu:SetNormalTexture''
                addBorder(bu, 1)
                bu:SetBorderColor(r, g, b)
                du:ClearAllPoints() du:SetPoint('CENTER', bu, 'BOTTOM', 2, -9)
            end
        end
        local d = _G[this:GetName()..'Border']
        if  d then
            local re, gr, bl = d:GetVertexColor()
            bu:SetBorderColor(re*.7, gr*.7, bl*.7)
        end
    end)

    --
