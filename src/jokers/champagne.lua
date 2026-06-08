SMODS.Joker{
    key = "champagne",
    atlas = "wjokers",
    pos = { x = 4, y = 2},

    config = {
        extra = {
            cards_left = 7,
            reps = 1
        }
    },

    loc_txt = {
        ['name'] = "Champagne Flute",
        ['text'] = {
            "Retrigger played {C:attention}Glass Cards",
            "{C:inactive}({C:attention}#1#{} {C:inactive}cards remaining)"
        }
    },

    cost = 6,
    rarity = 2,
        
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    
    loc_vars = function(self, info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return{
            vars = {
                card.ability.extra.cards_left
            }
        }
    end,

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play 
        and context.other_card.config.center_key == 'm_glass' and
        card.ability.extra.cards_left > 0 then
            card.ability.extra.cards_left = card.ability.extra.cards_left - 1
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        elseif context.after and not context.blueprint then
            if card.ability.extra.cards_left <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end,

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_glass') then
                return true
            end
        end
        return false
    end
}