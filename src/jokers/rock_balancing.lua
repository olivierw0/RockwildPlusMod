SMODS.Joker {
    key = "rock_balancing",
    atlas = 'wjokers',
    pos = { x = 4, y = 4 },

    config={
        extra = {
            xmult_gain = 0.75,
            xmult = 1
        }
    },

    loc_txt ={
        ['name'] = 'Rock Balancing',
        ['text']= {
            "Gains {X:mult,C:white} X#1# {} Mult when a hand",
            "is played with a {C:attention}Stone Card{} in it",
            "resets when a hand without is played",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        }
    },
    
    rarity = 2, 
    cost = 7,
    
    unlocked = true,
    discovered = true,

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self,card,context)
        if context.before then
            local reset = true
            print("scoring hand : ",context.scoring_hand)
            for _, v in ipairs(context.scoring_hand) do 
                if SMODS.has_enhancement(v,'m_stone') and not v.debuff then
                    reset = false
                    break
                end
            end

            if reset then
                card.ability.extra.xmult = 1
                return{
                    message = localize('k_reset')
                }
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return{
                    message = 'Balacing...',
                    colour = HEX("808080")
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
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