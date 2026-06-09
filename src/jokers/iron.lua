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
    cost = 5,
    
    unlocked = true,
    discovered = true,
    enhancement_gate = 'm_steel',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card,'m_steel') then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end,
}