

    local dummy         = function() end
    local blacklist     = {[ChatFrame2] = true,}
    local button        = {'UpButton', 'DownButton', 'BottomButton'}
    local channel       = {'SAY', 'YELL', 'PARTY', 'GUILD', 'OFFICER', 'RAID', 'RAID_WARNING', 'BATTLEGROUND', 'WHISPER', 'CHANNEL'}
    local _AddMessage   = ChatFrame1.AddMessage
    local _, class      = UnitClass'player'

    HEX_CLASS_COLORS = {
        ['DRUID']   = 'ff7d0a',
        ['HUNTER']  = 'abd473',
        ['MAGE']    = '69ccf0',
        ['PALADIN'] = 'f58cba',
        ['PRIEST']  = 'ffffff',
        ['ROGUE']   = 'fff569',
        ['SHAMAN']  = '0070de',
        ['WARLOCK'] = '9482c9',
        ['WARRIOR'] = 'c79c6e',
    }

    print = function(m)
        if  (not m) or m == '' then
            DEFAULT_CHAT_FRAME:AddMessage'nil'
        elseif  type(m) == 'table' then
            DEFAULT_CHAT_FRAME:AddMessage'table'
        else
            DEFAULT_CHAT_FRAME:AddMessage(m)
        end
    end

    SLASH_FRAMESTACK1 = '/fs'
    SLASH_FRAMESTACK2 = '/fstack'
    SLASH_FRAMESTACK3 = '/framestack'
    SlashCmdList.FRAMESTACK = function()
        print(GetMouseFocus():GetName())
    end

    SLASH_RL1 = '/rl'
    SLASH_RL2 = '/reload'
    SLASH_RL3 = '/reloadui'
    SlashCmdList.RL = function()
        ReloadUI()
    end

    local AddMessage = function(self, t,...)
        local colour = HEX_CLASS_COLORS[class]

        t = gsub(t, '|H(.-)|h%[(.-)%]|h', '|H%1|h%2|h')
        t = gsub(t, '%[(%d+)%. .+%].+(|Hplayer.+)', '|cfffdee00%1 •|r %2.')

        local d = date'%I.%M'..string.lower(date'%p')
        t = string.format('|cff'..colour..'%s|r |cfffdee00•|r %s', gsub(d, '0*(%d+)', '%1', 1), t)

    	return _AddMessage(self, t, ...)
    end

    local scroll = function(self, d)
    	if  d > 0 then
    		if  IsShiftKeyDown() then
    			self:ScrollToTop()
    		else
    			self:ScrollUp()
    		end
    	elseif d < 0 then
    		if  IsShiftKeyDown() then
    			self:ScrollToBottom()
    		else
    			self:ScrollDown()
    		end
    	end
    end

    for i = 1, NUM_CHAT_WINDOWS do
    	local f = _G['ChatFrame'..i]
    	f:EnableMouseWheel(true)
    	f:SetFading(false)
    	f:SetScript('OnMouseWheel', scroll)

        for _, v in pairs(button) do
    		v = _G['ChatFrame'..i..v]
    		v:Hide()
    		v.Show = dummy
    	end

        if  not blacklist[f] then
    		f.AddMessage = AddMessage
    	end
    end

    ChatFrameMenuButton:Hide()
    ChatFrameMenuButton.Show = dummy

    for _, v in pairs(channel) do
        ChatTypeInfo[v].sticky = 1
    end

    --
