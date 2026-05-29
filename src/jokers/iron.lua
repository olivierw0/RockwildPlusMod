SMODS.Joker {
    key = "iron",
    atlas = 'wjokers',
    pos = { x = 0, y = 0 },
    
    config = { 
        extra = { 
            mult = 6, 
            chips = 26 
        } 
    },
    
    rarity = 1,
    cost = 4,
    
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card,'m_steel') then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}