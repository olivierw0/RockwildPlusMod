SMODS.Joker {
    key = "flower_seeds",
    atlas = 'wjokers',
    pos = { x = 1, y = 0 },

    config={
        extra={
            mult=0, 
            mult_mod=1
        }
    },

    rarity = 1,
    cost = 5,

    perishable_compat = false,
    unlocked = true,
    discovered = true,

    loc_vars = function(self,info_queue,card)
        return{
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.change_suit then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message_card = card,
                message = "Grows!",
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {mult = card.ability.extra.mult}
        end
    end

}