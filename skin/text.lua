

    -- colour is no longer functionally applied here
    -- frames are instead collectedinto a table to be formatted within the options menu
    -- through the colourpickerframe

    LADYUI_WHITETEXT = {}
    LADYUI_TITLETEXT = {}

    local questW = {
        QuestLogObjectivesText,
        QuestLogTimerText,
        QuestLogQuestDescription,
        GossipGreetingText,
        QuestRewardText,
        QuestProgressText,
        QuestDescription,
        QuestObjectiveText,
        GreetingText,
        CurrentQuestsText,
        AvailableQuestsText,
    }

    local questT = {
        QuestLogQuestTitle,
        QuestLogDescriptionTitle,
        QuestLogRewardTitleText,
        QuestLogItemChooseText,
        QuestLogItemReceiveText,
        QuestLogSpellLearnText,
        QuestLogPlayerTitleText,
        QuestRewardRewardTitleText,
        QuestRewardItemChooseText,
        QuestRewardItemReceiveText,
        QuestRewardSpellLearnText,
        QuestProgressTitleText,
        QuestRewardTitleText,
        QuestDetailRewardTitleText,
        QuestProgressRequiredItemsText,
        QuestProgressRequiredMoneyText,
        QuestTitleText,
        QuestDetailObjectiveTitleText,
        QuestDetailRewardTitleText,
        QuestDetailItemChooseText,
        QuestDetailItemReceiveText,
        QuestDetailSpellLearnText,
    }

    for i = 1, 10 do
        tinsert(LADYUI_WHITETEXT, _G['QuestLogObjective'..i])
    end

    for i = 1, 32 do
        local t = _G['QuestTitleButton'..i]
        -- t:SetNormalFontObject(GameFontWhite)
    end

    for i = 1, 12 do
        tinsert(LADYUI_WHITETEXT, _G['SpellButton'..i..'SubSpellName'])
    end

    for _, v in pairs(questW) do
        tinsert(LADYUI_WHITETEXT, v)
    end

    for _, v in pairs(questT) do
        tinsert(LADYUI_TITLETEXT, v)
    end

    for _, v in pairs(LADYUI_WHITETEXT) do
        v:SetTextColor(1, 1, 1)
    end

    for _, v in pairs(LADYUI_TITLETEXT) do
        v:SetTextColor(1, .8, 0)
        v:SetShadowOffset(.5, -.5)
        v:SetShadowColor(1, .5, 0)
    end

    local escapes = {
        '|c%x%x%x%x%x%x%x%x', '',   -- color start
        '|r', '',                   -- color end
    }

    local function unescape(t)
        for i = 1, #escapes - 1, 2 do
            t = gsub(t, escapes[i], escapes[i + 1])
        end
        return t
    end

    local addGossip = function()
        for i = 1, 32 do
            local bu = _G['GossipTitleButton'..i]
            local t  = bu:GetText()
            if  t then
                t = unescape(t) -- strip colour formatting
                bu:SetText(t)
                bu:SetTextColor(1, 1, 1)
            end
        end
    end

    local addQuest = function()
        for i = 1, 32 do
            local bu = _G['QuestTitleButton'..i]
            local t  = bu:GetText()
            if  t then
                t = unescape(t)
                bu:SetText(t)
                bu:SetTextColor(1, 1, 1)
            end
        end
    end

    hooksecurefunc('QuestFrameGreetingPanel_OnShow',    addQuest)
    hooksecurefunc('GossipFrameUpdate',                 addGossip)
    hooksecurefunc('GossipFrameAvailableQuestsUpdate',  addGossip)
    hooksecurefunc('GossipFrameActiveQuestsUpdate',     addGossip)
    hooksecurefunc('GossipFrameOptionsUpdate',          addGossip)

    hooksecurefunc('ItemTextFrame_OnEvent', function()
        local material = ItemTextGetMaterial()
        if  material then
            local t, title = GetMaterialTextColors(material)
            ItemTextPageText:SetTextColor('P',  t[1],     t[2],     t[3])
			ItemTextPageText:SetTextColor('H1', title[1], title[2], title[3])
			ItemTextPageText:SetTextColor('H2', title[1], title[2], title[3])
			ItemTextPageText:SetTextColor('H3', title[1], title[2], title[3])
        else
            ItemTextPageText:SetTextColor('P',  1, 1, 1)
			ItemTextPageText:SetTextColor('H1', 1, 1, 1)
			ItemTextPageText:SetTextColor('H2', 1, 1, 1)
			ItemTextPageText:SetTextColor('H3', 1, 1, 1)
        end
    end)

    hooksecurefunc('QuestFrame_SetTextColor', function(t, material)
        local paper  = material == 'Parchment' and true or false
        local colour = GetMaterialTextColors(material)
        t:SetTextColor(paper and 1 or colour[1], paper and 1 or colour[1], paper and 1 or colour[1])
    end)

    hooksecurefunc('QuestFrame_SetTitleTextColor', function(t, material)
        t:SetTextColor(1, .8, 0)
        t:SetShadowOffset(.5, -.5)
        t:SetShadowColor(1, .5, 0)
    end)

    --
