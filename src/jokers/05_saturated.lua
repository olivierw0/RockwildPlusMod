SMODS.Joker {
    key = "saturated",
    atlas = "wjokers",
    pos = { x = 1, y = 4 },
    
    config = { 
        extra = { 
            xmult_mod = 0.15,
        }
    },

    rarity = 2,
    cost = 6,

    discovered = true,
    unlocked = true,

    loc_vars = function(self, info_queue, card)
        local current_suit = (G.GAME.current_round.saturated_card.suit or {}) or 'Spades'
        local n_cards = 0
        if G.playing_cards then
            for _, k in ipairs(G.playing_cards) do
                if k:is_suit(current_suit) then
                    n_cards = n_cards +1
                end
            end
        end
        return { 
            vars = { 
                card.ability.extra.xmult_mod, 
                localize(current_suit, 'suits_singular'),
                math.max(0,card.ability.extra.xmult_mod * n_cards),
                colours = { 
                    G.C.SUITS[current_suit] 
                }
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then 
            local n_cards = 0
            for _, k in ipairs(G.playing_cards) do
                if k:is_suit(G.GAME.current_round.saturated_card.suit) then
                    n_cards = n_cards +1
                end
            end
            return {
                xmult = math.max(0,card.ability.extra.xmult_mod * n_cards)
            }
        end
    end
}