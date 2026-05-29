SMODS.Joker {
    key = "rainbow",
    atlas = 'wjokers',
    pos = { x = 3, y = 0 },

    config = { 
        extra = { 
            xmult = 7
        } 
    },

    rarity = 3,
    cost = 7,
    
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    
    calculate = function(self, card, context)
        if context.joker_main then
            local wild_count = 0
            for _, scoring_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scoring_card, 'm_wild') then
                    wild_count = wild_count + 1
                end
            end
            
            if wild_count >= 5 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
