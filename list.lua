

    -- here you can add, take-away and style spells you want to track.
    -- this can easily be added to
    -- including skills beyond those procs and buffs already handled by SpellActivationOverlay.
    -- it will NOT currently handle cooldowns.

    modspells = {
       {    -- PRIEST                               -- KEY
            id = 139,                                -- spellid
            priority = 2,                           -- controls positioning of the string. lower number means it will stack above those w/ a higher one.
            show = true,                            -- toggle whether this aura will be tracked.
            Name = 'Renew',            -- aura name.
            symbol = '+',                         -- symbol or text you want to represent the aura with.
            size = 24,                              -- size of text.
            colour = { 0, 1, 0 }, -- RGB colour of text, can be numeric (0-1) or out of 255. in this case it's a nice yellow.
        },
    }
