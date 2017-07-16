

    MultiBarRightButton1:ClearAllPoints()
    MultiBarRightButton1:SetPoint('TOPRIGHT', UIParent, 'RIGHT', -6, (MultiBarRight:GetHeight() / 2))

    MultiBarLeftButton1:ClearAllPoints()
    MultiBarLeftButton1:SetPoint('TOPRIGHT', MultiBarRightButton1, 'TOPLEFT', -6, 0)

    MultiBarBottomRight:ClearAllPoints()
    MultiBarBottomRight:SetPoint('BOTTOM', MultiBarBottomLeft, 'TOP', 0, 4)
    MultiBarBottomRight.SetPoint = function() end

    function ShapeshiftBar_Update()
        ShapeshiftBar_UpdateState()
    end

    for _, frame in pairs({
        -- 'MultiBarLeft',
        'MultiBarRight',
        -- 'MultiBarBottomLeft',
        'MultiBarBottomRight',
        'ShapeshiftBarFrame',
        'PossessBarFrame',

        -- 'CONTAINER_OFFSET_Y',
        -- 'BATTLEFIELD_TAB_OFFSET_Y',

        'PETACTIONBAR_YPOS',
        -- 'PetActionBarFrame', -- (?)
    }) do
        UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
    end

    for _, frame in pairs({
        _G['PetActionBarFrame'],
        _G['ShapeshiftBarFrame'],
        _G['PossessBarFrame'],
        _G['MultiCastActionBarFrame'],
    }) do
        frame:SetMovable(true)
        frame:SetUserPlaced(true)
        frame:EnableMouse(false)
    end

    for _, button in pairs({
        _G['PossessButton1'],
        _G['PetActionButton1'],
        _G['ShapeshiftButton1'],
    }) do
        button:ClearAllPoints()
        button:SetPoint('BOTTOMLEFT', MainMenuBar, 'TOPLEFT', 40, 0)
        button:RegisterForDrag'LeftButton'

        button:HookScript('OnDragStart', function(self)
            if IsShiftKeyDown() and IsAltKeyDown() then
                self:StartMoving()
            end
        end)

        button:HookScript('OnDragStop', function(self)
            self:StopMovingOrSizing()
        end)
    end

    for _, button in pairs({
        _G['ActionBarUpButton'],
        _G['ActionBarDownButton'],
        _G['KeyRingButton'],
    }) do
        button:SetAlpha(0)
        button:EnableMouse(false)
    end

    local f = CreateFrame('Frame')
    f:Hide()

    for i = 2, 3 do
        for _, texture in pairs({
            _G['MainMenuBarPageNumber'],
            _G['SlidingActionBarTexture0'],
            _G['SlidingActionBarTexture1'],
            _G['ShapeshiftBarLeft'],
            _G['ShapeshiftBarMiddle'],
            _G['ShapeshiftBarRight'],
            _G['PossessBackground1'],
            _G['PossessBackground2'],
            _G['MainMenuBarTexture2'],
            _G['MainMenuBarTexture3']
        }) do
            texture:SetParent(f)
        end
    end

    for _, bar in pairs({
        _G['MainMenuBar'],
        _G['MainMenuExpBar'],
        _G['MainMenuBarMaxLevelBar'],
        _G['ReputationWatchStatusBar'],
        _G['ReputationWatchBar'],
    }) do
        bar:SetWidth(512)
        -- bar:SetFrameStrata('BACKGROUND')
    end

    for i = 0, 3 do
        local bar   = _G['MainMenuBarMaxLevelBar']
        local b     = _G['MainMenuMaxLevelBar'..i]
        b:SetWidth(128)
        bar:SetPoint('TOP', MainMenuBar, -60, -11)
    end

    local bp        = _G['MainMenuBarBackpackButton']
    local bpicon    = _G['MainMenuBarBackpackButtonIconTexture']
    local count     = _G['MainMenuBarBackpackButtonCount']
    bp:SetWidth(26)
    bp:SetHeight(26)
    bp:ClearAllPoints()
    bp:SetNormalTexture''
    bp:SetPoint('BOTTOM', MainMenuBarArtFrame, 275, 8)

    bpicon:SetTexCoord(.1, .9, .1, .9)

    count:ClearAllPoints()
    count:SetPoint('BOTTOM', bp, 1, 0)

    bp.arrow = bp:CreateTexture(nil, 'OVERLAY')
    bp.arrow:SetTexture[[Interface\MoneyFrame\Arrow-Right-Up]]
    bp.arrow:SetHeight(16)
    bp.arrow:SetWidth(16)
    bp.arrow:SetTexCoord(1,0,0,0,1,1,0,1)
    bp.arrow:SetPoint('BOTTOM', bp, 'TOP', 2, 1)

    bp.mouseover = CreateFrame('Button', nil, bp)
    bp.mouseover:SetWidth(30)
    bp.mouseover:SetHeight(100)
    bp.mouseover:SetPoint('BOTTOM', bp, 'TOP')
    bp.mouseover:SetFrameLevel(10)

    local ShowBags = function()
        bp.arrow:SetPoint('BOTTOM', bp, 'TOP', 2, 4)
        for i = 0, 3 do
            local s = _G['CharacterBag'..i..'Slot']
            s:SetAlpha(1)
            s:EnableMouse(true)
        end
    end

    local HideBags = function()
        bp.arrow:SetPoint('BOTTOM', bp, 'TOP', 2, 1)
        for i = 0, 3 do
            local s = _G['CharacterBag'..i..'Slot']
            s:SetAlpha(0)
            s:EnableMouse(false)
        end
    end

    local SetBagToggle = function(min, max, toggle)
        for i = min, max do
            if toggle == 'open' then OpenBag(i) else CloseBag(i) end
        end
    end

    ToggleBackpack = function()
        if  IsBagOpen(0) then
			CloseBankFrame()
			SetBagToggle(0, 11)
		else
            SetBagToggle(0, 4, 'open')
        end
    end

    bp:HookScript('OnEnter', ShowBags)
    bp:HookScript('OnLeave', HideBags)
    bp.mouseover:SetScript('OnEnter', ShowBags)
    bp.mouseover:SetScript('OnLeave', HideBags)

    for i = 0, 3 do
        local s = _G['CharacterBag'..i..'Slot']
        local t = _G['CharacterBag'..i..'SlotIconTexture']
        local c = _G['CharacterBag'..i..'SlotCount']
        s:SetWidth(14)
        s:SetHeight(14)
        s:SetNormalTexture''
        s:SetAlpha(0)
        s:EnableMouse(false)
        s:SetFrameLevel(11)

        c:SetFont(STANDARD_TEXT_FONT, 9, 'OUTLINE')
        c:ClearAllPoints()
        c:SetPoint('LEFT', s, 'RIGHT', 6, 1)

        t:SetTexCoord(.1, .9, .1, .9)

        if i == 0 then
            s:ClearAllPoints()
            s:SetPoint('BOTTOM', MainMenuBarBackpackButton, 'TOP', 0, 14)
        else
            s:ClearAllPoints()
            s:SetPoint('BOTTOM', _G['CharacterBag'..(i - 1)..'Slot'], 'TOP', 0, 6)
        end

        s:HookScript('OnEnter', ShowBags)
        s:HookScript('OnLeave', HideBags)
    end

    MainMenuBarTexture0:SetPoint('BOTTOM', MainMenuBarArtFrame, -128, 0)
    MainMenuBarTexture1:SetPoint('BOTTOM', MainMenuBarArtFrame, 128, 0)

    MainMenuMaxLevelBar0:SetPoint('BOTTOM', MainMenuBarMaxLevelBar, 'TOP', -128, 0)

    for i, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
        v:SetPoint('BOTTOM', MainMenuBarArtFrame, i == 1 and -289 or 289, 0)
        v.SetPoint = function() end
        v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]]
    end

    function MainMenuBarBackpackButton_UpdateFreeSlots()
    	local total, slots, family = 0
    	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
    		slots, family = GetContainerNumFreeSlots(i)
    		if  family == 0 then
    			total = total + slots
    		end
    	end

    	MainMenuBarBackpackButton.freeSlots = total
    	MainMenuBarBackpackButtonCount:SetText(total > 0 and string.format('%s', total) or '|cffff0000Full|r')
    end

    hooksecurefunc('MultiActionBar_Update', function()
        local one, two = GetActionBarToggles()
        for _, v in pairs({
            _G['PossessButton1'],
            _G['PetActionButton1'],
            _G['ShapeshiftButton1'],
        }) do
            local offset = SHOW_MULTI_ACTIONBAR_2 and 88 or SHOW_MULTI_ACTIONBAR_1 and 44 or 0
            v:SetPoint('BOTTOMLEFT', MainMenuBar, 'TOPLEFT', 40, offset)
        end
    end)

    --
