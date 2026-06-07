SMODS.Joker {
    key = "jungle",
    atlas = "wjokers",
    pos = { x = 1, y = 1},

    config = {
        extra = {
            xmult = 1.5
        }
    },

    loc_txt = {
        ['name'] = 'Welcome to the Jungle',
        ['text'] = {
            "Played {C:attention}Wild Cards{}",
            "gives {X:mult,C:white} X#1# {} Mult",
            "when scored",
        }
    },
    
    rarity = 3, 
    cost = 8,
    
    unlocked = true,
    discovered = true,

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild

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
    end,

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}