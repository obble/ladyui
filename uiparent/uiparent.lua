

    local unhook = {
        'CastingBarFrame',
        'CONTAINER_OFFSET_X',
        'CONTAINER_OFFSET_Y',
    }

    for _, v in pairs(unhook) do
        UIPARENT_MANAGED_FRAME_POSITIONS[v] = nil
    end

    CastingBarFrame:SetPoint('BOTTOM', UIParent, 0, 230)

    UIPARENT_MANAGED_FRAME_POSITIONS['CONTAINER_OFFSET_X'] = {
        baseX = 20,
        rightLeft = 90,
        rightRight = 45,
        isVar = 'xAxis'
    }

    UIPARENT_MANAGED_FRAME_POSITIONS['CONTAINER_OFFSET_Y'] = {
        baseY = 70,
        bottomEither = 27,
        bottomRight = 0,
        reputation = 9,
        isVar = 'yAxis',
        pet = 23
    }
