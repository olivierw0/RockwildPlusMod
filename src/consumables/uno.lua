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
            plus = 2,
            max = 2
        }
    },
    
    loc_txt={
        ['name'] = '+2 Card',
        ['text'] = {
            "Increases rank of",
            "{C:attention}#2#{} selected cards",
            "by {C:attention}#1#",
        }
    },

    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.plus,
                card.ability.extra.max
            }
        } 
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == card.ability.extra.max
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

    config = { max_highlighted = 2, min_highlighted = 2 },      
    
    loc_txt={
        ['name'] = 'Reverse Card',
        ['text'] = {
            "Select {C:attention}#1#{} cards,",
            "{C:attention}Increase{} the rank of the {C:attention}left{} card",
            "{C:attention}Decrease{} the rank of the {C:attention}right{} card",
        }
    },

    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end,

    -- can_use = function (self, card)
    --     return G.hand and #G.hand.highlighted == card.ability.max_highlighted 
    -- end,

    use = function(self, card, area, copier)
        if G.hand.highlighted and #G.hand.highlighted == 2 then
            local rightmost = G.hand.highlighted[1]

            local base_percent = 1.15
            local sound = 'card1'
            local extra = nil
            for i=1, #G.hand.highlighted do 
                if G.hand.highlighted[i].T.x > rightmost.T.x then 
                    rightmost = G.hand.highlighted[i] 
                end 
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after', 
                delay = 0.4, 
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true 
                end 
            }))
            delay(0.2)
            for i=1, #G.hand.highlighted do
                local percent = nil
                percent = base_percent - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function() 
                        G.hand.highlighted[i]:flip()
                        play_sound(sound, percent, extra)
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
                        if G.hand.highlighted[i] ~= rightmost then
                            assert(SMODS.modify_rank(G.hand.highlighted[i], 1))
                        else
                            assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
                        end
                        return true
                    end
                }))
            end
            
            sound = 'tarot2' 
            base_percent = 0.85
            extra = .6

            for i=1, #G.hand.highlighted do
                local percent = nil
                percent = base_percent + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function() 
                        G.hand.highlighted[i]:flip()
                        play_sound(sound, percent, extra)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true      
                    end 
                }))
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function() 
                    G.hand:unhighlight_all()
                    return true      
                end 
            }))
        end
    end,

    -- use = function (self, card, area, copier)
    --     G.E_MANAGER:add_event(Event({
    --         trigger = 'after',
    --         delay = 0.4,
    --         func = function()
    --             play_sound('tarot1')
    --             card:juice_up(0.3, 0.5)
    --             return true
    --         end
    --     }))
    --     for i = 1, #G.hand.highlighted do
    --         local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
    --         G.E_MANAGER:add_event(Event({
    --             trigger = 'after',
    --             delay = 0.15,
    --             func = function()
    --                 G.hand.highlighted[i]:flip()
    --                 play_sound('card1', percent)
    --                 G.hand.highlighted[i]:juice_up(0.3, 0.3)
    --                 return true
    --             end
    --         }))
    --     end
    --     delay(0.2)
    --     for i = 1, #G.hand.highlighted do
    --         G.E_MANAGER:add_event(Event({
    --             trigger = 'after',
    --             delay = 0.1,
    --             func = function()
    --                 -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
    --                 assert(SMODS.modify_rank(G.hand.highlighted[i], -card.ability.extra.minus))
    --                 return true
    --             end
    --         }))
    --     end
    --     for i = 1, #G.hand.highlighted do
    --         local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
    --         G.E_MANAGER:add_event(Event({
    --             trigger = 'after',
    --             delay = 0.15,
    --             func = function()
    --                 G.hand.highlighted[i]:flip()
    --                 play_sound('tarot2', percent, 0.6)
    --                 G.hand.highlighted[i]:juice_up(0.3, 0.3)
    --                 return true
    --             end
    --         }))
    --     end
    --     G.E_MANAGER:add_event(Event({
    --         trigger = 'after',
    --         delay = 0.2,
    --         func = function()
    --             G.hand:unhighlight_all()
    --             return true
    --         end
    --     }))
    --     delay(0.5)
    -- end,
}

-- Skip Card
SMODS.Consumable{
    key = 'skip',
    set = 'Uno',
    atlas = 'others',
    pos = {x = 2, y=0},
    
    unlocked = true,
    discovered = true,

    config ={
        extra = {
            p_tags = {'tag_foil','tag_holo','tag_polychrome','tag_negative','tag_uncommon','tag_rare'}
        }
    },
    loc_txt={
        ['name'] = 'Skip Card',
        ['text'] = {
            "Gain a random",
            "{C:attention}Joker Tag{}",
        }
    },


    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_foil', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_holo', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_negative', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_uncommon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag(pseudorandom_element(card.ability.extra.p_tags, pseudoseed('unoskip'))))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
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
    
    loc_txt={
        ['name'] = 'Wild Card',
        ['text'] = {
            "Create a {C:attention}Wild{} copy",
            "of a selected card",
        }
    },

    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    end,

    can_use = function(self,card)
        return G.hand and #G.hand.highlighted == 1
    end,

    use = function (self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
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
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
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