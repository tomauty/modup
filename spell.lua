

    local function tlength(t)
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
    end

    for i = tlength(modspells), 1, -1 do    -- SCORE INFO
        local spell = modspells[i]
        if not spell.id then
            print('modup: |cff01DFD7Spell ID missing in entry', i, '! Check your info is correct in list.lua.')
        else
            if not spell.priority then spell.priority = 1 end
            spell.name = spell.Name
            if not spell.name then
                print('modup: |cff01DFD7Spell', spell.id, 'doesn\'t exist! Check your info is correct in listofspells.lua.')
                tremove(modspells, i)
            end
        end
    end

    local function sortSpells(a, b)         -- SORT
            -- show lower priority first, or alphabetically within same priority
        return a.priority < b.priority or a.priority == b.priority and a.name < b.name
    end

    table.sort(modspells, sortSpells)

    local f = CreateFrame'Frame'            -- IMPLEMENT
    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:RegisterEvent'UNIT_AURA'

    local fontstrings = setmetatable({}, { __index = function(t, i)
        local line = UIParent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
        if i > 1 then
            line:SetPoint('BOTTOMRIGHT', t[i - 1], 'TOPRIGHT', 0, -5)
        else
            line:SetPoint('RIGHT', UIParent, 'CENTER', 96, 75)
        end
        line:SetJustifyH'RIGHT'
        line:SetShadowOffset(0, 0)
        line:SetSpacing(2)
        t[i] = line
        return line
    end})

    local modBuff = function(spell, count)
        local shown = 0
        if spell.show then
            shown = shown + 1
            local fontstring = fontstrings[shown] -- keep them all in another indexed table
            fontstring:SetText(string.rep(spell.symbol, count > 0 and count or 1))
            fontstring:SetFont(STANDARD_TEXT_FONT, spell.size, 'OUTLINE')
            fontstring:SetTextColor(spell.colour[1], spell.colour[2], spell.colour[3])
            fontstring:Show()
        end
        for i = shown + 1, tlength(fontstrings) do
            fontstrings[i]:Hide()
        end
    end

    f:SetScript('OnEvent', function()
        local i = 1
    	while true do
            GameTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
    		GameTooltip:ClearLines()
    		GameTooltip:SetPlayerBuff(GetPlayerBuff(i, 'HELPFUL'))
            local stack = GetPlayerBuffApplications(i)
    		local buff  = GameTooltipTextLeft1:GetText()


            for j = 1, tlength(modspells) do
                local spell = modspells[j]
                if buff and string.find(spell.name, buff) then modBuff(spell, stack) end
            end

            GameTooltip:Hide()
            if not buff then break end
            i = i + 1
        end
    end)

    --
