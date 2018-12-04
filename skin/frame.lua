

    LADYUI_COLOURELEMENTS_FOR_UI = {}
    LADYUI_COLOURELEMENTS_BORDER_FOR_UI = {}

    local b = GameTimeFrame:CreateTexture(nil, 'OVERLAY')
    b:SetPoint('TOPLEFT', GameTimeFrame)
    b:SetPoint('BOTTOMRIGHT', GameTimeFrame, 33, -33)
    b:SetTexture[[Interface\Minimap\MiniMap-TrackingBorder]]
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, b)

    for _, v in pairs({
            -- MINIMAP CLUSTER
        MinimapBorder,
        MiniMapMailBorder,
        MiniMapTrackingBorder,
        MiniMapMeetingStoneBorder,
        MiniMapMailBorder,
        MiniMapBattlefieldBorder,
        MiniMapWorldBorder,
            -- UNIT & CASTBAR
        PlayerFrameTexture,
        TargetFrameTexture,
        PetFrameTexture,
        PartyMemberFrame1Texture,
        PartyMemberFrame2Texture,
        PartyMemberFrame3Texture,
        PartyMemberFrame4Texture,
        PartyMemberFrame1PetFrameTexture,
        PartyMemberFrame2PetFrameTexture,
        PartyMemberFrame3PetFrameTexture,
        PartyMemberFrame4PetFrameTexture,
        TargetofTargetTexture,
        CastingBarFrameBorder,
            -- MAIN MENU BAR
        MainMenuBarTexture0,
        MainMenuBarTexture1,
        MainMenuBarTexture2,
        MainMenuBarTexture3,
        MainMenuMaxLevelBar0,
        MainMenuMaxLevelBar1,
        MainMenuMaxLevelBar2,
        MainMenuMaxLevelBar3,
        MainMenuXPBarTextureLeftCap,
        MainMenuXPBarTextureRightCap,
        MainMenuXPBarTextureMid,
        BonusActionBarTexture0,
        BonusActionBarTexture1,
        ReputationWatchBarTexture0,
        ReputationWatchBarTexture1,
        ReputationWatchBarTexture2,
        ReputationWatchBarTexture3,
        ReputationXPBarTexture0,
        ReputationXPBarTexture1,
        ReputationXPBarTexture2,
        ReputationXPBarTexture3,
        SlidingActionBarTexture0,
        SlidingActionBarTexture1,
        MainMenuBarLeftEndCap,
        MainMenuBarRightEndCap,
        ExhaustionTick:GetNormalTexture(),
        _G[TargetFrameSpellBar:GetName()..'Border']
    }) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end

        -- chat
    local a, b, c = select(6, ChatFrameEditBox:GetRegions())
    for _, v in pairs({a, b, c}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end


        -- BAGS
    for i = 1, 12 do
        local bagName = 'ContainerFrame'..i
        local _, a, b, _, c, _, d = _G[bagName]:GetRegions()
        for _, v in pairs({a, b, c, d}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end
        local a, b = _G[bagName..'Portrait'], _G[bagName..'BackgroundMiddle2']
        for _, v in pairs({a, b, c}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end
    end


        -- BANK
    local _, a = BankFrame:GetRegions()
    for _, v in pairs({a}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end


        -- BOOK
    local _, a, b, c, d = ItemTextFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    ItemTextFrame.Material = ItemTextFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    ItemTextFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    ItemTextFrame.Material:SetWidth(510)
    ItemTextFrame.Material:SetHeight(525)
    ItemTextFrame.Material:SetPoint('TOPLEFT', ItemTextFrame, 26, -80)
    ItemTextFrame.Material:SetVertexColor(.7, .7, .7)


        -- HELP
    local a, b, c, d, e, f, g = HelpFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- HONOR
    local a, b, c, d = HonorFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- LOOT
    local _, a = LootFrame:GetRegions()
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, a)

    local _, a = LFGParentFrame:GetRegions()
    for _, v in pairs({a}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end


        -- MERCHANT
    local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
    for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, MerchantBuyBackItemNameFrame)


        -- MAIL
    local _, a, b, c, d = OpenMailFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    local _, a, b, c, d = MailFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    MailFrame.Material = MailFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    MailFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    MailFrame.Material:SetWidth(530) MailFrame.Material:SetHeight(540)
    MailFrame.Material:SetPoint('TOPLEFT', MailFrame, 23, -74)
    MailFrame.Material:SetVertexColor(.7, .7, .7)


        -- MIRRORBAR
    for i = 1, MIRRORTIMER_NUMTIMERS do
        local m = _G['MirrorTimer'..i]
        local _, _, a = m:GetRegions()
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, a)
    end


        -- PAPERDOLL
    local a, b, c, d, _, e = PaperDollFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- POPUP
    for i = 1, 4 do
        local f = _G['StaticPopup'..i]
        tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, f)
    end


        -- QUEST
    QuestGreetingFrameHorizontalBreak:SetWidth(278)

    for _, v in pairs({
        QuestFrameGreetingPanel,
        QuestFrameDetailPanel,
        QuestFrameProgressPanel,
        QuestFrameRewardPanel,
        GossipFrameGreetingPanel}) do
        local a, b, c, d = v:GetRegions()
        for _, j in pairs({a, b, c, d}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, j) end

        v.Material = v:CreateTexture(nil, 'OVERLAY', nil, 7)
        v.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
        v.Material:SetWidth(506)
        v.Material:SetHeight(506)
        v.Material:SetPoint('TOPLEFT', v, 24, -82)
        v.Material:SetVertexColor(.7, .7, .7)

        if v == GossipFrameGreetingPanel or v == QuestFrameGreetingPanel then
            v.Corner = v:CreateTexture(nil, 'OVERLAY', nil, 7)
            v.Corner:SetTexture[[Interface\QuestFrame\UI-Quest-BotLeftPatch]]
            v.Corner:SetWidth(132)
            v.Corner:SetHeight(64)
            v.Corner:SetPoint('BOTTOMLEFT', v, 21, 68)
            tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v.Corner)
        end
    end


        -- QUEST LOG
    local _, _, a, b, c, d = QuestLogFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    QuestLogFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    QuestLogFrame.Material:SetWidth(510)
    QuestLogFrame.Material:SetHeight(398)
    QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame)
    QuestLogFrame.Material:SetVertexColor(.7, .7, .7)


        -- QUEST TIMER
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, QuestTimerFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, QuestTimerHeader)

        -- RAIDINFO
    local _, _, a = RaidInfoFrame:GetRegions()
    for _, v in pairs({a}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- REPUTATION
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, ReputationDetailFrame)
    local a, b, c, d = ReputationFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end
    for i = 1, 15 do
        local a, b = _G['ReputationBar'..i]:GetRegions()
        for _, v in pairs({a, b}) do
            tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
        end
    end

        -- SCOREBOARD
    local a, b, c, d, e, f, _, _, _, _, _, _, g = WorldStateScoreFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- SKILL
    local a, b, c, d = SkillFrame:GetRegions()
    for _, v in pairs({a, b, c ,d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end
    for _, v in pairs({ReputationDetailCorner, ReputationDetailDivider}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- SOCIAL
    local _, a, b, c, d = FriendsFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    local a = ({GuildMemberDetailFrame:GetRegions()})
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, a[20])
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, GuildMemberDetailFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, GuildMemberDetailCorner)


        -- SPELLBOOK
    local _, a, b, c, d = SpellBookFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

    SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    SpellBookFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    SpellBookFrame.Material:SetWidth(525)
    SpellBookFrame.Material:SetHeight(535)
    SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 28, -74)
    SpellBookFrame.Material:SetVertexColor(.7, .7, .7)

        -- TABARD
    local _, a, b, c, d = TabardFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- TAXI
    local _, a, b, c, d = TaxiFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- TRADE
    local _, _, a, b, c, d = TradeFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- WARDROBE
    local _, a, b, c, d = DressUpFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- WORLDMAP
    local _, a, b, c, d, e, _, _, f, g, h, j, k = WorldMapFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g, h, j, k}) do
        tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- COLOUR PICKER
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, ColorPickerFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, ColorPickerFrameHeader)


        -- MENU
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, GameMenuFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, GameMenuFrameHeader)


        -- GRAPHICS MENU
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, OptionsFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, OptionsFrameHeader)


        -- SOUND MENU
    tinsert(LADYUI_COLOURELEMENTS_BORDER_FOR_UI, SoundOptionsFrame)
    tinsert(LADYUI_COLOURELEMENTS_FOR_UI, SoundOptionsFrameHeader)

        -- ADDONS
    local f = CreateFrame'Frame'
    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if arg1 == 'Blizzard_AuctionUI' then            -- AUCTION
            local _, a, b, c, d, e, f = AuctionFrame:GetRegions()
            for _, v in pairs({a, b, c, d, e, f}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b = AuctionDressUpFrame:GetRegions()
            local _, _, _, c = AuctionDressUpFrameCloseButton:GetRegions()
            for _, v in pairs({a, b, c}) do tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v) end
            for i = 1, 15 do
                local a = _G['AuctionFilterButton'..i]:GetNormalTexture()
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, a)
            end
        elseif arg1 == 'Blizzard_CraftUI' then          -- CRAFT
            local _, a, b, c, d = CraftFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_InspectUI' then        -- INSPECT
            local a, b, c, d = InspectPaperDollFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b, c, d = InspectHonorFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_MacroUI' then          -- MACRO
            local _, a, b, c, d = MacroFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b, c, d = MacroPopupFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_RaidUI' then
            local _, a = ReadyCheckFrame:GetRegions()   -- READYCHECK
            tinsert(LADYUI_COLOURELEMENTS_FOR_UI, a)
        elseif arg1 == 'Blizzard_TalentUI' then         -- TALENTS
            local _, a, b, c, d = PlayerTalentFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_TradeSkillUI' then     -- TRADESKILL
            local _, a, b, c, d = TradeSkillFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_TrainerUI' then        -- TRAINER
            local _, a, b, c, d = ClassTrainerFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                tinsert(LADYUI_COLOURELEMENTS_FOR_UI, v)
            end
        end
    end)

    local OnEvent = function()
        for _, v in pairs(LADYUI_COLOURELEMENTS_FOR_UI) do
             v:SetVertexColor(0, 0, 0)
        end
        for _, v in pairs(LADYUI_COLOURELEMENTS_BORDER_FOR_UI) do
             v:SetBackdropBorderColor(0, 0, 0)
        end
    end

    local e = CreateFrame'Frame'
    e:RegisterEvent'PLAYER_LOGIN'
    e:SetScript('OnEvent', OnEvent)


    --
