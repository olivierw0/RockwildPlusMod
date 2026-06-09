SMODS.Joker {
    key = "ricochet",
    atlas = 'wjokers',
    pos = { x = 6, y = 0 },
    
    config = {
        extra = {
            reps = 1
        }
    },
    
    rarity = 2, 
    cost = 6,
    
    unlocked = true,
    discovered = true,
    enhancement_gate = 'm_stone',

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,


    calculate = function(self,card,context)
        if context.repetition and SMODS.has_enhancement(context.other_card,'m_stone') then 
            if context.cardarea == G.play then 
                return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.reps,
                        card = card
                }
            elseif context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
                return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.reps,
                        card = card
                }
            end
        end
    end,
}