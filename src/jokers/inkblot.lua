SMODS.Joker{
    key = "inkblot",
    atlas = "wjokers",
    pos = { x = 2, y = 4},

    config = {
        extra = {
            usable = true,
            poker_hand = 'High Card'
        }
    },

    loc_txt={
        ['name'] = "Ink Blot Joker",
        ['text'] = {
            "Once per round, creates a copy of",
            "{C:attention}1{} random {C:attention}consumable{} in your",
            "possession if hand played is {C:attention}#1#{},",
            "{s:0.8}poker hand changes each round",
            "{C:inactive}(Must have room)"
        }
    },
    
    rarity = 3,
    cost = 8,

    loc_vars = function(self,info_queue,card)
        return{
            vars = {
                localize(card.ability.extra.poker_hand, 'poker_hands')
            }
        }
    end,

    unlocked = true,
    discovered = true,

    calculate = function(self, card,context)

        if context.first_hand_drawn then
            local eval = function() return card.ability.extra.usable and not G.RESET_JIGGLES end
            juice_card_until(card, eval, false)
        end

        if context.before and context.scoring_name == card.ability.extra.poker_hand and G.consumeables.cards[1] and card.ability.extra.usable then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'inkblot')
                        local copied_card = copy_card(card_to_copy)
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        G.GAME.consumeable_buffer = 0
                        card.ability.extra.usable = false
                        return true
                    end
                }))
                return {
                    message = "I see it!",
                    colour = HEX("0F0F0F")
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.usable = true
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'inkblot')
            return {
                message = "I see a...",
                colour = HEX("0F0F0F")
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'inkblot')
    end

}