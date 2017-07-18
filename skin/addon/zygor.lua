

    local load = function()
        local _, a, b, c, d, e = ZygorGuidesViewerFrame:GetRegions()
        for _, v in pairs({a, b, c, d, e, ZygorGuidesViewerMapIconOverlay}) do
            v:SetVertexColor(0, 0, 0)
        end
    end

    local e = CreateFrame'Frame'
    e:RegisterEvent'ADDON_LOADED'
    e:SetScript('OnEvent', function(self, event, addon)
        if  addon == 'ZygorGuidesViewer' then
            load()
            e:UnregisterAllEvents()
        end
    end)


    --
