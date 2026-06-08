SMODS.Joker {
    key = "balancingrock",
    atlas = 'wjokers',
    pos = { x = 4, y = 4 },

    config={
        extra = {
            xmult_gain = 0.75,
            xmult = 1
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
            for _, v in ipairs(context.scoring_hand) do 
                if SMODS.has_enhancement(v,'m_stone') and not v.debuff then
                    reset = false
                    break
                end
            end

            if reset then
                card.ability.extra.xmult = 1
                return{
                    -- add sfx rock falling
                    message = localize('k_reset'),
                    colour = HEX("808080")
                }
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return{
                    -- add a SFX zen
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