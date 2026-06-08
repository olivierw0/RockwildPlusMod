SMODS.ConsumableType{
    key = 'Uno',
    default = 'reverse',
    primary_colour = G.C.RED,
    secondary_colour = G.C.BLACK,
    collection_rows = { 2, 3 },
    shop_rate = 0
}

-- +2 Card
SMODS.Consumable{
    key = 'plus_two',
    set = 'Uno',
    pos = {x = 3, y=0},
    atlas = 'others',

    unlocked = true,
    discovered = true,

    config = {
        extra = {
            plus = 2
        }
    },
    
    loc_txt={
        ['name'] = '+2 Card',
        ['text'] = {
            "Increase rank of",
            "a selected card by {C:attention}#1#",
        }
    },

--alt
    -- loc_txt={
    --     ['name'] = '+2 Card',
    --     ['text'] = {
    --         "Get 1 copie of {C:attention}#1#",
    --         "Selected Cards",
    --     }
    -- },

    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.plus
            }
        } 
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == 1
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.plus))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

-- Reverse Card
SMODS.Consumable{
    key = 'reverse',
    set = 'Uno',
    atlas = 'others',
    pos = {x = 1, y=0},

    unlocked = true,
    discovered = true,

    config = {
        extra = {
            minus = 1
        }
    },
    
    loc_txt={
        ['name'] = 'Reverse Card',
        ['text'] = {
            "Decrease the rank of",
            "a selected card by {C:attention}#1#",
        }
    },

    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.minus
            }
        }
    end,

    can_use = function (self, card)
        return G.hand and #G.hand.highlighted == 1
    end,

    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -card.ability.extra.minus))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

-- Skip Card
SMODS.Consumable{
    key = 'skip',
    set = 'Uno',
    atlas = 'others',
    pos = {x = 2, y=0},
    
    unlocked = true,
    discovered = true,
    
    loc_txt={
        ['name'] = 'Skip Card',
        ['text'] = {
            "Gain a random",
            "{C:attention}Tag{}",
        }
    },

    can_use = function(self, card)
        return true
    end,

    use = function (self, card, area, copier)
        -- local counter = 0
        -- local random_key = nil
        
        -- for key, _ in pairs(G.P_TAGS) do
        --     counter = counter + 1
        --     -- 1 in counter chance to pick the current key
        --     if math.random(1, counter) == 1 then
        --         random_key = key
        --     end
        -- end
        -- add_tag({key = random_key})

        local tag_pool = get_current_pool('Tag')
        local selected_tag = pseudorandom_element(tag_pool, 'whiteem')
        local it = 1
        while selected_tag == 'UNAVAILABLE' do
            it = it + 1
            selected_tag = pseudorandom_element(tag_pool, 'whiteem' .. it)
        end
        add_tag(Tag(selected_tag, false, 'Small'))
    end
}

-- Wild Card
SMODS.Consumable{
    key = 'wild',
    set = 'Uno',
    atlas = 'others',
    pos = { x= 4, y=0},
        
    unlocked = true,
    discovered = true,

    config = {
        extra = {
            number = 2,
            level = 1
        }
    },

    loc_vars = function (self, info_queue, card)
        return{
            vars = {
                card.ability.extra.number,
                card.ability.extra.level
            }
        } 
    end,
    
    loc_txt={
        ['name'] = 'Wild Card',
        ['text'] = {
            "Upgrade your {C:attention}#1#",
            "{C:attention}most{} played hands",
            "by {C:attention}#2#{} levels",
        }
    },

    can_use = function(self,card)
        return true
    end,

    use = function (self,card,area,copier)
        local _hands = {}
        local hand_list = {}
        
        -- Single loop to collect all hands with their play counts
        for hand_key, hand in pairs(G.GAME.hands) do
            
            table.insert(hand_list, {key = hand_key, played = hand.played})
        end
        
        -- Sort by play count (highest first)
        table.sort(hand_list, function(a, b) return a.played > b.played end)
        
        -- Take the top N hands
        for i = 1, math.min(card.ability.extra.number, #hand_list) do
            table.insert(_hands, hand_list[i].key)
        end
        
        print('hands :', _hands)
        SMODS.upgrade_poker_hands({hands=_hands, level_up=card.ability.extra.level, from = card})
    end
}

-- Wild 4 Card
SMODS.Consumable{
    key = 'wild4',
    set = 'Uno',
    atlas = 'others',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1},
    
    hidden = true,
    soul_set = 'Uno',

    config = {
        extra = {
            cards = 4
        }
    },
        
    unlocked = true,
    discovered = true,
    
    loc_txt={
        ['name'] = 'Wild +4 Card',
        ['text'] = {
            "Create {C:attention}#1# Wilds{} copies",
            "of a selected card",
        }
    },

    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.extra.cards
            }
        } 
    end,

    can_use = function(self,card)
        return G.hand and #G.hand.highlighted == 1
    end,

    use = function (self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, card.ability.extra.cards do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    _card:set_ability('m_wild')
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
    end
}