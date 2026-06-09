SMODS.Joker {
    key = "lucky7",
    atlas = "wjokers",
    pos = { x = 0, y = 1 },

    config = { 
        extra = { 
            minus_dollars=-1, 
            dollars=7, 
            xmult = 2, 
            odds = 2
        } 
    },

    rarity = 1,
    cost = 5,

    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = 
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'jackpot')
        return { 
            vars = { 
                card.ability.extra.minus_dollars, 
				card.ability.extra.xmult,
                numerator, 
                denominator,
                card.ability.extra.dollars, 
            } 
        }
    end,

    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.minus_dollars
            return{
                    x_mult = card.ability.extra.xmult,
                    dollars=card.ability.extra.minus_dollars,
            }
        elseif context.joker_main and context.cardarea == G.jokers then
            for _,k in ipairs(context.scoring_hand) do
                if k:get_id() == 7 then
                    if SMODS.pseudorandom_probability(card, "jackpot", 1, card.ability.extra.odds) then 
                        return{
                            dollars = card.ability.extra.dollars,
                            message = 'Jackpot!',
                        }
                    else 
                        return{
                            message = 'Nope!',
                        }
                    end
                end
            end
        end
    end
}