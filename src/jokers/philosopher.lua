SMODS.Joker {
    key = 'philosopher',
    atlas = 'wjokers',
    pos = { x = 5, y = 1 },
    soul_pos = { x = 5, y = 2},

    rarity = 1, 
    cost = 3,
    
    blueprint_compat = false,
    
    unlocked = true,
    discovered = true,
    enhancement_gate = 'm_stone',

    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,

    calculate = function(self, card, context)
        if context.check_enhancement and context.other_card.config.center_key == 'm_stone' then
            return {m_gold = true}
        end
    end,
}