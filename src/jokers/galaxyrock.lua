SMODS.Joker {
    key = 'galaxyrock',
    atlas = 'wjokers',
    pos = { x = 3, y = 3},

    loc_vars= function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,

    rarity = 1,
    cost = 5,

    unlocked = true,
    discovered = true,

    blueprint_compat=false,

    calculate = function(self,card,context)
        if (SMODS.find_card(self.key)[1] == card) and context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and SMODS.has_enhancement(context.full_hand[1], 'm_stone') then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _planet = nil
                            for _,v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.current_round.most_played_poker_hand then 
                                    _planet = v.key
                                end
                            end
                            if _planet then
                                SMODS.add_card({ key = _planet })
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        end
                    }))
                    return{
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet,
                        remove = true
                    }
                end
                return {
                    remove = true
                }
            end
        end
    end,

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end

}