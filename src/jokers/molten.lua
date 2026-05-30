SMODS.Joker {
    key = "molten",
    atlas = 'wjokers',
    pos = { x = 4, y = 0 },

    config = { 
        extra = { 
            dollars = 6 
        } 
    },

    rarity = 2,
    cost = 7,

    blueprint_compat = false,
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars} }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and
        (SMODS.has_enhancement(context.other_card, 'm_gold') or SMODS.has_enhancement(context.other_card, 'm_steel')) then
            return {
                dollars = card.ability.extra.dollars,
            }
        end

        -- code pour si on veut après le scoring, probleme avec si on fait après,
        -- il peut y avoir plusieurs proc d'argent
        if context.after and not context.blueprint then
            for i = 1,#context.scoring_hand,1 do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_gold') or SMODS.has_enhancement(context.scoring_hand[i], 'm_steel') then
                    context.scoring_hand[i]:set_ability(G.P_CENTERS["m_stone"],false,1)
                    return{
                        message_card = context.scoring_hand[i],
                        message="Melts.."
                    }
                end
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