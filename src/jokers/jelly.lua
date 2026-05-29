SMODS.Joker {
    key = 'jelly',
    atlas = 'wjokers',
    pos = { x = 4, y = 1},

    config = {
        extra = {
            base = 1,
        }
    },

    rarity = 2,
    cost = 5,

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
            local booster = SMODS.add_booster_to_shop('p_spectral_jumbo_1')
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
    
