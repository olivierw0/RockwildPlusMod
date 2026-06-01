SMODS.Joker {

    key = 'capitalist',
    atlas = 'wjokers',
    pos = { x = 1, y = 3},

    config = {
        extra = {
            xchips = 3,
            mult = -17
        }
    },

    rarity = 1,
    cost = 5,

    loc_txt = {
        ['name'] = "Capitalist Joker",
        ['text'] = {
            "{X:chips,C:white} X#1# {} Chips",
            "{C:mult}#2#{} Mult",
            "{C:inactive}(Mult cannot be less than 1)",
        }
    },

    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xchips,
                card.ability.extra.mult,
            }
        }
    end,

    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.joker_main then 
                return {
                    xchips = card.ability.extra.xchips,
                    mult = (-mult)+math.max(mult+card.ability.extra.mult, 1)
                }

        end 
    end
}