SMODS.Joker {
    key = "jackpot",
    atlas = "wjokers",
    pos = { x = 0, y = 1 },

    config = { 
        extra = { 
            dollars=20, 
            xmult = 7, 
            odds = 2
        } 
    },

    rarity = 1,
    cost = 5,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = 
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'jackpot')
        return { 
            vars = { 
                numerator, 
                denominator,
                card.ability.extra.dollars, 
				card.ability.extra.xmult
            } 
        }
    end,

    calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.joker_main
		then
            local n_sevens = 0
            for _,k in ipairs(context.full_hand) do
                if k:get_id() == 7 then
                    n_sevens = n_sevens + 1
                end
            end
            if n_sevens >= 3 then 
                if SMODS.pseudorandom_probability(card, "jackpot", 1, card.ability.extra.odds) then 
                    return {
                        message = 'Jackpot!',
                        x_mult = card.ability.extra.xmult,
                        dollars = card.ability.extra.dollars
                    }
                else 
                    return {
                        message = 'Nope!'
                    }
                end
            end
        end
    end
}