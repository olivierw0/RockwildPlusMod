SMODS.Joker {
    key = "rainbow",
    atlas = 'wjokers',
    pos = { x = 3, y = 0 },

    config = { 
        extra = { 
            xmult = 7
        } 
    },

    loc_txt = {
        ['name'] = "ROYGBIV",
        ['text'] = {
            "{X:mult,C:white} X#1# {} Mult if played",
            "hand cointains {C:attention}5 Wild Cards{}",
        }
    },

    rarity = 3,
    cost = 7,
    
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.xmult } }
    end,

    
    calculate = function(self, card, context)
        if context.joker_main then
            local wild_count = 0
            for _, scoring_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scoring_card, 'm_wild') then
                    wild_count = wild_count + 1
                end
            end
            
            if wild_count >= 5 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,

    in_pool = function(self, args) 
        local cpt = 0
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                cpt = cpt + 1
            end
        end
        if cpt>=5 then return true else return false end
    end
}
