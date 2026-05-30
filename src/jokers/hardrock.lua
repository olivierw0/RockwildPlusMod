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

    loc_vars = function (self,info_queue,card)
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

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end
}