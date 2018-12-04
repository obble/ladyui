
	local size, spacing = 28, 6
	local buttons, bankbuttons = {}, {}

	local grab_slots = function()
		local numBags = 1
		for i = 1, NUM_BAG_FRAMES do
			local bagName = 'ContainerFrame'..i + 1
			if  _G[bagName]:IsShown() and not _G[bagName..'BackgroundTop']:GetTexture():find'Bank' then
				numBags = numBags + 1
			end
		end
		return numBags
	end

	local BagSpace = function()
		local ct = 0
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				local  link = GetContainerItemLink(bag, slot)
				if not link then ct = ct + 1 end
			end
		end
		return ct
	end

	local BankSpace = function()
		local ct = 0
		for i = 1, 28 do
		    local  id   = BankButtonIDToInvSlotID(i)
			local  link = GetInventoryItemLink('player', id)
			if not link then ct = ct + 1 end
		end
		for bag = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				local  link = GetContainerItemLink(bag, slot)
				if not link then ct = ct + 1 end
			end
		end
		return ct
	end

	local HideBags = function(bagName)
		local  bag = _G[bagName]
		if not bag.stripped then
			for i = 1, 7 do select(i, bag:GetRegions()):SetAlpha(0) end
			bag:EnableMouse(false)
			_G[bagName..'CloseButton']:Hide()
			_G[bagName..'PortraitButton']:EnableMouse(false)
			bag.stripped = true
		end
	end

	local AddBankSlotPurchase = function()
		local num, full = GetNumBankSlots()
		local cost      = GetBankSlotCost(num)

		_G['trustfund'].purchase:Hide()

		if not full then
			_G['trustfund'].purchase:Show()

			-- MoneyFrame_Update(_G['trustfund'].purchase, cost)

			_G['trustfund'].purchase:SetScript('OnClick', function()
				PlaySound'igMainMenuOption'
				StaticPopup_Show'CONFIRM_BUY_BANK_SLOT'
			end)
		end
	end

	local HideBank = function()
		BankFrame:EnableMouse(false)
		BankFrame:EnableMouse(false)
		BankFrame:DisableDrawLayer'BACKGROUND'
		BankFrame:DisableDrawLayer'BORDER'
		BankFrame:DisableDrawLayer'OVERLAY'


		for _, v in pairs({
			BankFrameCloseButton,
			BankFrameMoneyFrame,
			BankPortraitTexture,
			BankFramePurchaseInfo
		}) do
			v:Hide()
		end
	end

	local HideBankArt = function()	-- previously bankArtToggle(x) (we dont need x)
		AddBankSlotPurchase()
		HideBank()

		if  _G['trustfund']:GetWidth() < 200 then
		end

		for _, v in pairs({BankFrameMoneyFrameInset, BankFrameMoneyFrameBorder}) do
			v:Hide()
		end
	end

	local AddBG = function(bu)
		bu.bg = bu:CreateTexture(nil, 'BACKGROUND', nil, 7)
		bu.bg:SetTexture[[Interface\PaperDoll\UI-Backpack-EmptySlot]]
		bu.bg:SetTexCoord(.1, .9, .1, .9)
		bu.bg:SetAlpha(.5)
		bu.bg:SetAllPoints()
	end

	local bu, con, bag, col, row
	local MoveButtons = function(table, frame)
		local columns = ceil(sqrt(#table))
		col, row = 0, 0

		for i = 1, #table do
			bu = table[i]
			bu:SetHeight(size)
			bu:SetWidth(size)
			bu:ClearAllPoints()
			bu:SetPoint('TOPLEFT', frame, col*(size + spacing) + 9, -1*row*(size + spacing) - 67)

			if not bu.bg then AddBG(bu) end

			if col > (columns - 2) then
				col = 0
				row = row + 1
			else
				col = col + 1
			end
		end

		frame:SetHeight((row + (col == 0 and 0 or 1))*(size + spacing) + 96)
		frame:SetWidth(columns*size + spacing*(columns - 1) + 20)
		col, row = 0, 0
	end

	local ReAnchor = function()
		buttons = {}
		for f = 1, grab_slots() do
			con = 'ContainerFrame'..f
			HideBags(con)
			for i = GetContainerNumSlots(_G[con]:GetID()), 1, -1 do
				bu = _G[con..'Item'..i]
				tinsert(buttons, bu)
			end
		end
		MoveButtons(buttons, _G['handbag'])
		_G['handbag']:Show()
	end

	local cachedBankWidth, cachedBankHeight				-- setup bank
	local ReAnchorBank = function(noMoving)
		for _, button in pairs(bankbuttons) do button:Hide() end

		bankbuttons = {}

		for i = 1, 28 do
			local bu = _G['BankFrameItem'..i]
			tinsert(bankbuttons, bu)
			bu:Show()
		end

		local bagNameCount = 0
		for f = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
			bagNameCount = bagNameCount + 1
			con = 'ContainerFrame'..grab_slots() + bagNameCount
			HideBags(con)
			for i = GetContainerNumSlots(f), 1, -1  do
				bu = _G[con..'Item'..i]
				tinsert(bankbuttons, bu)
				bu:Show()
			end
		end

		if not noMoving then
			MoveButtons(bankbuttons, _G['trustfund'])
			cachedBankWidth  = _G['trustfund']:GetWidth()
			cachedBankHeight = _G['trustfund']:GetHeight()
		else
			_G['trustfund']:SetWidth(cachedBankWidth)
			_G['trustfund']:SetHeight(cachedBankHeight)
		end

		if _G['trustfund']:GetWidth() < 200 then
			for i = 1, 7 do BankSlotsFrame['Bag'..i]:SetScale(.85) end
		end

		_G['trustfund']:Show()
		_G['trustfund'].purchase:Show()
		for i = 1, 7 do
			local slot = _G['BankFrameBag'..i]
			slot:Show()
		end
	end

	local CloseBags = function()					-- toggle functions
		HideBankArt()
		for i = 0, 11 do CloseBag(i) end
		for _, v in pairs({_G['handbag'], _G['trustfund']}) do v:Hide() end
	end

	local CloseBags2 = function()
		CloseBankFrame()
		for _, v in pairs({_G['handbag'], _G['trustfund']}) do v:Hide() end
	end

	local OpenBags = function()
		HideBankArt()
		for i = 0, 4 do OpenBag(i) end
	end

	local ToggleBags = function()
		if  IsBagOpen(0) then
			CloseBankFrame()
			CloseBags()
		else OpenBags() end
	end

	for i = 1, 5 do
		local bag = _G['ContainerFrame'..i]
		hooksecurefunc(bag, 'Show', ReAnchor)
		hooksecurefunc(bag, 'Hide', CloseBags2)
	end

	hooksecurefunc(BankFrame, 'Show', function()
		for i = 0, 11 do OpenBag(i) end
		ReAnchorBank()
		HideBankArt()
	end)

	hooksecurefunc(BankFrame, 'Hide', function()
		CloseBags()
		HideBankArt()
	end)

	local HideBank = function()
		for i = 1, 28 do
			_G['BankFrameItem'..i]:Hide()
		end
		for i = 5, 11 do CloseBag(i) end
		_G['trustfund']:Hide()
		ReAnchor()
	end

	ToggleBackpack = ToggleBags
	ToggleBag      = ToggleBags
	OpenAllBags    = OpenBags
	OpenBackpack   = OpenBags
	CloseAllBags   = CloseBags

	local OnEvent = function()
		_G['handbag'].close:SetScript('OnClick',
			function() CloseBankFrame() CloseBags() end
		)
		_G['trustfund'].close:SetScript('OnClick', CloseBankFrame)
	end

	local e = CreateFrame'Frame'
	e:RegisterEvent'PLAYER_LOGIN'
	e:SetScript('OnEvent', OnEvent)
