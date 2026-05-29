SMODS.Joker{
    key='trashcan',
    atlas='wjokers',
    pos={x=2,y=1},

    config={
        extra={
            odds = 2,
            dollars = 1
        }
    },

    rarity = 1,
    cost = 5,
    
    unlocked = true,
    discovered = true,

    loc_vars = function(self,info_queue,card)
        local numerator, denominator = 
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'trashcan')
        return { 
            vars = { 
                numerator, 
                denominator,
                card.ability.extra.dollars
            } 
        }
    end,

    calculate = function (self,card,context)
        if context.individual and context.cardarea == "unscored" and 
        SMODS.pseudorandom_probability(card, "trashcan", 1, card.ability.extra.odds) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, this goes after the dollar modification
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end 
    end,
}