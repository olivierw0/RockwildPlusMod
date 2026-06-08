SMODS.Joker {
    key = "melting",
    atlas = 'wjokers',
    pos = { x = 4, y = 0 },

    config = { 
        extra = { 
            dollars = 7 
        } 
    },

    rarity = 3,
    cost = 8,

    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return {vars = {card.ability.extra.dollars} }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint
        and (SMODS.has_enhancement(context.other_card, 'm_gold') or 
            SMODS.has_enhancement(context.other_card, 'm_steel')) 
        then
            return { dollars = card.ability.extra.dollars }
        end

        if context.after and context.cardarea == G.jokers and not context.blueprint then
            local those_cards = {}
            for _, v in ipairs(context.scoring_hand) do 
                if (SMODS.has_enhancement(v, 'm_gold') or SMODS.has_enhancement(v, 'm_steel')) then 
                    table.insert(those_cards,v) 
                end
            end
            for _, v in ipairs(those_cards) do 
                v:set_ability(G.P_CENTERS["m_stone"],false,1)
                -- add SFX PSSSCH metal in water
                juice_card(v)
                SMODS.calculate_effect({message = "Melts...", colour = HEX("FFC084")}, v)
            end            
        end
    end,

    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') or
               SMODS.has_enhancement(playing_card,'m_gold') then
                return true
            end
        end
        return false
    end

}