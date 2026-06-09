SMODS.Joker{
    key = "jobapplication",
    atlas = "wjokers",
    pos = { x = 3, y = 4},

    config = { extra = { price = 2, poker_hand = 'High Card' } },

    rarity = 1,
    cost = 3,

    unlocked = true,
    discovered = true,    

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price, localize(card.ability.extra.poker_hand, 'poker_hands')} }
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == card.ability.extra.poker_hand then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
                return {
                    message = "Hired!",
                    colour = G.C.MONEY
                }
            else
                card.ability.extra_value = 1
                card:set_cost()
                return {
                    message = "Fired!",
                    colour = G.C.RED
                }
            end
        end

        if context.after and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then -- Can be the same 2 times in a row
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'get_a_job')
            return {
                message = "New offer...",
            }
        end
    end
}