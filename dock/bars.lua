

    local _, class = UnitClass'player'
    local CLASS_ICON_TCOORDS = {
    	['WARRIOR']		= {0, .25, 0, .25},
    	['MAGE']		= {.25, .49609375, 0, .25},
    	['ROGUE']		= {.49609375, 0.7421875, 0, .25},
    	['DRUID']		= {.7421875, 0.98828125, 0, .25},
    	['HUNTER']		= {0, .25, .25, 0.5},
    	['SHAMAN']	 	= {.25, .49609375, .25, 0.5},
    	['PRIEST']		= {.49609375, .7421875, .25, .5},
    	['WARLOCK']		= {.7421875, .98828125, .25, .5},
    	['PALADIN']		= {0, .25, .5, .75},
    	['DEATHKNIGHT']	= {.25, .5, .5, .75},
    	['MONK']		= {.5, .73828125, .5, .75},
    	['DEMONHUNTER']	= {.7421875, .98828125, .5, .75},
    };

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
        button:SetPoint('CENTER', UIParent)

        button:SetMovable(true)
        button:SetUserPlaced(true)
        button:RegisterForDrag('LeftButton')

        button:HookScript('OnDragStart', function(self)
            if (IsShiftKeyDown() and IsAltKeyDown()) then
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
        }) do
            -- texture:ClearAllPoints()
            -- texture:SetPoint('TOP', UIParent, 99999, 99999)
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

    local bp        = _G['MainMenuBarBackpackButton']
    local bpicon    = _G['MainMenuBarBackpackButtonIconTexture']
    bp:SetWidth(20)
    bp:SetHeight(20)
    bp:ClearAllPoints()
    bp:SetNormalTexture''
    bp:SetPoint('BOTTOM', MainMenuBarArtFrame, 308, 6)
    bpicon:SetTexCoord(.1, .9, .1, .9)

    for i = 0, 3 do
        _G['CharacterBag'..i..'Slot']:SetWidth(14)
        _G['CharacterBag'..i..'Slot']:SetHeight(14)
        _G['CharacterBag'..i..'Slot']:SetNormalTexture''
        _G['CharacterBag'..i..'SlotIconTexture']:SetTexCoord(.1, .9, .1, .9)
    end

    _G['CharacterBag0Slot']:ClearAllPoints()
    _G['CharacterBag0Slot']:SetPoint('BOTTOM', MainMenuBarArtFrame, 264, 6)
    _G['CharacterBag1Slot']:ClearAllPoints()
    _G['CharacterBag1Slot']:SetPoint('BOTTOM', MainMenuBarArtFrame, 264, 25)
    _G['CharacterBag2Slot']:ClearAllPoints()
    _G['CharacterBag2Slot']:SetPoint('BOTTOM', MainMenuBarArtFrame, 282, 6)
    _G['CharacterBag3Slot']:ClearAllPoints()
    _G['CharacterBag3Slot']:SetPoint('BOTTOM', MainMenuBarArtFrame, 282, 25)


    MainMenuBarTexture0:SetPoint('BOTTOM', MainMenuBarArtFrame, -128, 0)
    MainMenuBarTexture1:SetPoint('BOTTOM', MainMenuBarArtFrame, 128, 0)
    MainMenuBarTexture3:Hide()

    MainMenuMaxLevelBar0:SetPoint('BOTTOM', MainMenuBarMaxLevelBar, 'TOP', -128, 0)

    for i, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
        v:SetPoint('BOTTOM', MainMenuBarArtFrame, i == 1 and -289 or 289, 0)
        v.SetPoint = function() end
        v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]]
    end

    CharacterMicroButton:ClearAllPoints()
    CharacterMicroButton:SetPoint('BOTTOMLEFT', 9000, 9000)

    local menu = CreateFrame('Frame', 'ladymenu', MainMenuBarArtFrame)
    menu:SetWidth(20)
    menu:SetHeight(20)
    menu:SetPoint('BOTTOM', MainMenuBarArtFrame, -308, 6)

    menu.t = menu:CreateTexture(nil, 'ARTWORK')
    menu.t:SetTexture[[Interface\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-CLASSES]]
    menu.t:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
    menu.t:SetAllPoints()

    --
