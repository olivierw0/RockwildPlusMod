SMODS.Joker {
    key = "jungle",
    atlas = "wjokers",
    pos = { x = 1, y = 1},

    config = {
        extra = {
            xmult = 1.5
        }
    },

    rarity = 3, 
    cost = 8,
    
    unlocked = true,
    discovered = true,

    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }        
    end,


    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play 
        and SMODS.has_enhancement(context.other_card,'m_wild') then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}