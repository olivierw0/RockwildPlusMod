SMODS.Joker {
    key = "jungle",
    atlas = "wjokers",
    pos = { x = 1, y = 1},

    config = {
        extra = {
            type = 'Flush'
        }
    },
    
    rarity = 2, 
    cost = 7,
    
    unlocked = true,
    discovered = true,
    enhancement_gate = 'm_wild',

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {
            vars = {
                localize(card.ability.extra.type, 'poker_hands')
            }
        }
    end,


    calculate = function(self,card,context)
        if context.before and next(context.poker_hands[card.ability.extra.type]) then 
            for i= #context.scoring_hand, 1, -1 do
                if SMODS.has_enhancement(context.scoring_hand[i],"m_wild") then
                    return {
                        level_up = true,
                        message = localize('k_level_up_ex')
                    }
                end
            end
        end
    end,
}