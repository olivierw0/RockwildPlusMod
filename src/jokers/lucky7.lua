SMODS.Joker {
    key = "lucky7",
    atlas = "wjokers",
    pos = { x = 0, y = 1 },


    config = { 
        extra = { 
            minus_dollars=-1, 
            xmult = 2, 
            number = 7, 
            cash_out = 15,
            cur_seven = 0
        } 
    },

    rarity = 1,
    cost = 6,

    unlocked = true,
    discovered = true,

    eternal_compat = false,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.minus_dollars, 
				card.ability.extra.xmult,
				card.ability.extra.number,
				card.ability.extra.cash_out,
				card.ability.extra.cur_seven,
            } 
        }
    end,

    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.minus_dollars
            card.ability.extra.cur_seven=card.ability.extra.cur_seven+1                
            return{
                    x_mult = card.ability.extra.xmult,
                    dollars=card.ability.extra.minus_dollars,
            }
        end

        if context.joker_main and context.cardarea == G.jokers and card.ability.extra.cur_seven >= card.ability.extra.number then
            card.ability.extra.cur_seven = card.ability.extra.cur_seven - card.ability.extra.number
            return{
                --SFX casino
                message = 'Jackpot!',
                colour = G.C.MONEY,
                dollars = card.ability.extra.cash_out
            } 
        end
    end
}