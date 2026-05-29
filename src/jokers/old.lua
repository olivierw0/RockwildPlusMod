SMODS.Joker{ 
    key = "old",
    atlas = "wjokers",
    pos = { x = 1, y = 2 },

    config = {
        extra = {
            mult = 5,
        }
    },
    
    cost = 6,
    rarity = 1,

    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        local current_suit = G.GAME.current_round.old_card and G.GAME.current_round.old_card.suit or "Spades"
        return {vars = {
            card.ability.extra.mult,
            localize(current_suit, 'suits_singular'), 
            colours = {G.C.SUITS[current_suit]}
        }
    }
    end,

    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.old_card.suit) then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}