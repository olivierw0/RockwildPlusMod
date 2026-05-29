SMODS.Joker{ 
    key = "young",
    atlas = "wjokers",
    pos = { x = 0, y = 2 },

    config = {
        extra = {
            chips = 18,
        }
    },
    
    cost = 4,
    rarity = 1,

    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        local current_suit = G.GAME.current_round.young_card and G.GAME.current_round.young_card.suit or "Spades"
        return {
            vars = {
                card.ability.extra.chips,
                localize(current_suit, 'suits_singular'), 
                colours = {G.C.SUITS[current_suit]}
            }
        }
    end,

    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.young_card.suit) then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
}