SMODS.Joker {
    key = 'jelly',
    atlas = 'wjokers',
    pos = { x = 4, y = 1},

    config = {
        extra = {
            base = 2,
        }
    },

    loc_txt = {
        ['name'] = "Eerie Jelly",
        ['text'] = {
            "Adds {C:attention}1{} free {C:spectral}Spectral Pack",
            "at start of shop", 
            "{C:inactive}({C:attention}#1#{} {C:inactive}rounds remaining)",
        }
    },

    rarity = 2,
    cost = 6,

    eternal_compat=false,
    unlocked = true,
    discovered = true,

    loc_vars = function(self,info_queue,card)
        return{
            vars = {
                card.ability.extra.base
            }
        }
    end,
    calculate = function(self,card,context)
        if context.starting_shop then
            if not context.blueprint then 
                card.ability.extra.base = card.ability.extra.base - 1
            end
            local booster = SMODS.add_booster_to_shop('p_spectral_normal_1')
            booster.ability.couponed = true
            booster:set_cost()

            if card.ability.extra.base - 1 < 0 then
                SMODS.destroy_cards(card, nil, nil, true)
            end
            return{
                message = "Boo!",
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
    end
}
    
