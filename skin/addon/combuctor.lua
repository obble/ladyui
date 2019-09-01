
local sv=PlayerFrameTexture.SetVertexColor;

ladyui_skin_combuctor = function()
	--skin bags
		local bagregions = { CombuctorFrame1:GetRegions(); };
		table.remove(bagregions,1);
        for _, v in pairs(bagregions) do
			sv(v, 0, 0, 0);
		end
	
	--skin bank
		local bankregions = { CombuctorFrame2:GetRegions(); };
		table.remove(bankregions,1);
        for _, v in pairs(bankregions) do
        	sv(v, 0, 0, 0);
        end
	
	--skin filters
	
		for i=0,11 do
			local filtertabregions = { _G["CombuctorItemFilter"..i]:GetRegions(); }
			table.remove(filtertabregions,2);
			for _, v in pairs(filtertabregions) do
				sv(v, 0, 0, 0)
			end
		end
		
	-- tab skin setup
	_G["CombuctorFrame1"]:HookScript("OnShow", ladyui_skin_combuctortabs)
	_G["CombuctorFrame2"]:HookScript("OnShow", ladyui_skin_combuctortabs)
end

ladyui_skin_combuctortabs = function (this)
		for i=1, 4 do 
		local curtab=this:GetName().."Tab"..i;
			if _G[curtab] then
				local bagtabregions = { _G[curtab]:GetRegions(); }
				bagtabregions[7]=nil
				bagtabregions[8]=nil
				for _, v in pairs(bagtabregions) do
					if not v:IsObjectType("FontString") then
						sv(v, 0, 0, 0);
					end
				end	
			end
		end
end

local waitTable = {};
local waitFrame = nil;

function ladyui__wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end

local e = CreateFrame("frame");
e:RegisterEvent("ADDON_LOADED");
e:SetScript("OnEvent", function(self, event, addon)
  		ladyui__wait(0.5,ladyui_skin_combuctor);
end);
