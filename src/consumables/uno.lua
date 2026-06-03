SMODS.ConsumableType{
    key = 'uno',
    default = 'wild4',
    primary_colour = G.C.RED,
    secondary_colour = G.C.BLACK,
    collection_rows = { 3, 4 },
    shop_rate = 0
}

SMODS.Consumable{
    key = 'plus_two',
    set = 'uno',
    pos = {x = 0, y=0},
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

SMODS.Consumable{
    key = 'reverse',
    set = 'uno',
    atlas = 'others',
    pos = {x = 0, y=0},

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

SMODS.Consumable{
    key = 'skip',
    set = 'uno',
    atlas = 'others',
    pos = {x = 0, y=0},
    
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
        local counter = 0
        local random_key = nil
        
        for key, _ in pairs(G.P_TAGS) do
            counter = counter + 1
            -- 1 in counter chance to pick the current key
            if math.random(1, counter) == 1 then
                random_key = key
            end
        end
        add_tag({key = random_key})
        local _tag = G.GAME.tags[#G.GAME.tags]

        if _tag then 
            if _tag.config.type == 'immediate' then 
                _tag:apply_to_run({type = 'immediate'})
            end
        end
    end
}

SMODS.Consumable{
    key = 'wild',
    set = 'uno',
    atlas = 'others',
    pos = { x= 0, y=0},
        
    unlocked = true,
    discovered = true,

    config = {
        extra = {
            number = 3,
            level = 2
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
        
    end
}

SMODS.Consumable{
    key = 'wild4',
    set = 'uno',
    atlas = 'others',
    pos = { x = 0, y = 0 },
    
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