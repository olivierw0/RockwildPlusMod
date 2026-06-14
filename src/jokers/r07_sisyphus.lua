SMODS.Joker {
    key = "sisyphus",
    atlas = 'wjokers',
    pos = { x = 4, y = 4 },

    config={
        extra = {
            xchips_mod = 0.25,
            xchips = 0.5
        }
    },
    
    rarity = 2, 
    cost = 6,
    
    unlocked = true,
    discovered = true,

    enhancement_gate = 'm_stone',

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.xchips_mod,
                card.ability.extra.xchips
            }
        }
    end,

    calculate = function(self,card,context)

        if context.discard and not context.other_card.debuff and
            SMODS.has_enhancement(context.other_card,'m_stone') and not context.blueprint 
        then
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_mod
            return{
                message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips } },
                colour = G.C.BLUE,
                delay = 0.45
            }
        end

        if context.ante_end and context.modify_ante and not context.blueprint then
            card.ability.extra.xchips = 0.5
            return{
                message = localize('k_reset'),
                colour = G.C.BLUE,
            }
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
}