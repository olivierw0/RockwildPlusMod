SMODS.Joker {
    key = 'philosopher',
    atlas = 'wjokers',
    pos = { x = 5, y = 1 },

    rarity = 1, 
    cost = 3,
    
    blueprint_compat = false,
    
    unlocked = true,
    discovered = true,

    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,

    calculate = function(self, card, context)
        if context.check_enhancement and context.other_card.config.center_key == 'm_stone' then
            return {m_gold = true}
        end
    end,

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end
}