

    local _, class = UnitClass'player'

    local CLASS_ICON_TCOORDS = {
    	['WARRIOR']		= {0, .25, .025, .225},
    	['MAGE']		= {.26, .5, .025, .225},
    	['ROGUE']		= {.49609375, 0.7421875, .025, .225},
    	['DRUID']		= {.7421875, 0.98828125, .025, .225},
    	['HUNTER']		= {.01, .249, .275, .475},
    	['SHAMAN']	 	= {.25, .49609375, .275, .475},
    	['PRIEST']		= {.497, .741, .275, .475},
    	['WARLOCK']		= {.7421875, .98828125, .275, .475},
    	['PALADIN']		= {0, .25, .525, .725},
    }

    local buttons = {
        ['CharacterMicroButton']    = {{-12, 10}, {-12, 10}},
        ['SpellbookMicroButton']    = {{ 12, 10}, { 12, 10}},
        ['TalentMicroButton']       = {{-12, 40}, {-12, 40}},
        ['QuestLogMicroButton']     = {{-12, 40}, { 12, 40}},
        ['SocialsMicroButton']      = {{ 12, 40}, {-12, 70}},
        ['LFGMicroButton']          = {{-12, 70}, { 12, 70}},
        ['MainMenuMicroButton']     = {{ 12, 70}, {-12, 100}},
        ['HelpMicroButton']         = {{-12, 100}, {12, 100}},
    }

    local menu = CreateFrame('Button', 'ladymenuButton', MainMenuBarArtFrame)
    menu:SetWidth(26)
    menu:SetHeight(26)
    menu:SetPoint('BOTTOM', MainMenuBarArtFrame, -275, 8)
    menu:RegisterForClicks'AnyUp'

    menu.t = menu:CreateTexture(nil, 'ARTWORK')
    menu.t:SetTexture[[Interface\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-CLASSES]]
    menu.t:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
    menu.t:SetPoint'TOPLEFT'
    menu.t:SetPoint('BOTTOMRIGHT', 0, 5)

    menu.arrow = menu:CreateTexture(nil, 'OVERLAY')
    menu.arrow:SetTexture[[Interface\MoneyFrame\Arrow-Right-Up]]
    menu.arrow:SetHeight(16)
    menu.arrow:SetWidth(16)
    menu.arrow:SetTexCoord(1,0,0,0,1,1,0,1)
    menu.arrow:SetPoint('BOTTOM', menu, 'TOP', 2, 1)

    menu.mouseover = CreateFrame('Button', nil, menu)
    menu.mouseover:SetWidth(60)
    menu.mouseover:SetHeight(300)
    menu.mouseover:SetPoint('BOTTOM', menu, 'TOP')
    menu.mouseover:SetFrameLevel(10)

    menu.sb = CreateFrame('StatusBar', nil, menu)
    menu.sb:SetStatusBarTexture[[Interface\AddOns\ladyui\art\statusbar.tga]]
    menu.sb:SetPoint('BOTTOMLEFT', 1, 1)
    menu.sb:SetPoint('BOTTOMRIGHT', -2, 1)
    menu.sb:SetHeight(4)
    menu.sb:SetStatusBarColor(0, 1, 0)
    menu.sb:SetBackdrop(
        {bgFile = [[Interface\Buttons\WHITE8x8]],
        insets = {
           left     =  -1,
           right    =  -1,
           top      =  -1,
           bottom   =  -1,
            }
        }
    )
    menu.sb:SetBackdropColor(0, 0, 0)
    menu.sb.updateInterval = 0

    MicroButtonPortrait:SetWidth(14)
    MicroButtonPortrait:SetHeight(21)
    MicroButtonPortrait:SetPoint('TOP', 0, -22)

    KeyRingButton:SetParent(ContainerFrame1)
    KeyRingButton:ClearAllPoints()
    KeyRingButton:SetPoint('TOPLEFT', ContainerFrame1, -25, -2)

    UpdateTalentButton = function() end

    local ShowMenu = function()
        menu.arrow:SetPoint('BOTTOM', menu, 'TOP', 2, 4)
        for i, v in pairs(buttons) do
            local bu = _G[i]
            bu:SetAlpha(1)
            bu:EnableMouse(true)
        end
    end

    local HideMenu = function()
        GameTooltip:Hide()
        menu.arrow:SetPoint('BOTTOM', menu, 'TOP', 2, 1)
        for i, v in pairs(buttons) do
            local bu = _G[i]
            bu:SetAlpha(0)
            bu:EnableMouse(false)
        end
    end

    local AddMenu = function()
        local l = UnitLevel'player'
        for i, v in pairs(buttons) do
            local bu = _G[i]
            bu:SetHeight(48)
            bu:SetWidth(23)
            bu:ClearAllPoints()
            bu:SetPoint('BOTTOM', menu, 'TOP', l < 10 and v[1][1] or v[2][1], l < 10 and v[1][2] or v[2][2])
            bu:SetAlpha(0)
            bu:EnableMouse(false)
            bu:SetFrameLevel(11)

            bu:HookScript('OnEnter', ShowMenu)
            bu:HookScript('OnLeave', HideMenu)
        end
    end

    menu:SetScript('OnEnter', function()
        ShowMenu()
        GameTooltip:ClearLines()
        GameTooltip:SetOwner(menu, 'ANCHOR_LEFT', -25, 12)
        GameTooltip:AddLine(MAINMENU_BUTTON)

        GameTooltip:AddLine' '

        -- latency
        local _, _, latency = GetNetStats()
        local string = format(MAINMENUBAR_LATENCY_LABEL, latency)
    	GameTooltip:AddLine(string, 1, 1, 1)
    	if  SHOW_NEWBIE_TIPS == '1' then
    		GameTooltip:AddLine(NEWBIE_TOOLTIP_LATENCY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
    	end

        GameTooltip:AddLine'\n'

        -- fps
        local string = format(MAINMENUBAR_FPS_LABEL, GetFramerate())
    	GameTooltip:AddLine(string, 1, 1, 1)
    	if  SHOW_NEWBIE_TIPS == '1' then
    		GameTooltip:AddLine(NEWBIE_TOOLTIP_FRAMERATE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
    	end

        GameTooltip:Show()
    end)
	menu:SetScript('OnLeave',      HideMenu)
    menu.mouseover:SetScript('OnEnter', ShowMenu)
    menu.mouseover:SetScript('OnLeave', HideMenu)

    menu:SetScript('OnClick', function()
        ToggleCharacter'PaperDollFrame'
    end)

    menu.sb:SetScript('OnUpdate', function(self)
        if  this.updateInterval > 0 then
            this.updateInterval = this.updateInterval - arg1
        else
			this.updateInterval = PERFORMANCEBAR_UPDATE_INTERVAL
			local _, _, latency = GetNetStats()
			if  latency > PERFORMANCEBAR_MEDIUM_LATENCY then
				menu.sb:SetStatusBarColor(1, 0, 0)
			elseif latency > PERFORMANCEBAR_LOW_LATENCY then
				menu.sb:SetStatusBarColor(1, 1, 0)
			else
				menu.sb:SetStatusBarColor(0, 1, 0)
            end
		end
    end)

    local e = CreateFrame'Frame'
    e:RegisterEvent'PLAYER_LOGIN'
    e:RegisterEvent'PLAYER_LEVEL_UP'
    e:SetScript('OnEvent', AddMenu)

    --
