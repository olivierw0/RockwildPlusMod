SMODS.Joker {
    key = "hardrock",
    atlas = 'wjokers',
    pos = { x = 2, y = 0 },
    
    config = {
        extra = {
            xchips = 2
        }
    },


    
    rarity = 3, 
    cost = 8,
    
    unlocked = true,
    discovered = true,
    enhancement_gate = 'm_stone',

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.xchips
            }
        }        
    end,


    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play 
        and SMODS.has_enhancement(context.other_card,'m_stone') then 
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
}