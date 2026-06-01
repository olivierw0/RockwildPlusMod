SMODS.Joker{
    key = 'communist',
    atlas = 'wjokers',

    pos = { x = 0, y = 3},

    config = {
        extra = {
            mult = 17,
            consumable_slot = -1,
        }
    },

    loc_txt = {
        ['name'] = 'Communist Joker',
        ['text'] = {
            '{C:mult}+#1#{} Mult',
            '{C:red}#2#{} consumable slot',
        }
    },

    loc_vars = function(self,info_queue,card)
        return{
            vars = {
                card.ability.extra.consumable_slot,
                card.ability.extra.mult,
            }
        }
    end,

    rarity = 1,
    cost = 4,

    unlocked = true,
    discovered = true,

    calculate = function(self,card,context)
        if context.joker_main then 
            return { mult = card.ability.extra.mult }
        end
    end,

    add_to_deck = function(self,card,from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slot
    end,

    remove_from_deck = function(self,card,from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slot
    end
}