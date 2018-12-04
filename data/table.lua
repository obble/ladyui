

    tlength = function(t)
        local count = 0
        if  t then
            for _ in pairs(t) do count = count + 1 end
        end
        return count
    end


    --
