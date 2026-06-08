SMODS.Joker {
    key = 'medusa',
    atlas = 'wjokers',
    pos = { x = 3, y = 1},

    config = {
        extra = {
            stoned = false
        }
    },

    loc_vars=function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,

    rarity = 2,
    cost = 5,
    

    blueprint_compat = false,
    unlocked = true,
    discovered = true,

    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return not card.ability.extra.stoned end
            juice_card_until(card, eval, true)
            
        elseif context.individual and context.cardarea == "unscored" 
        and (#context.full_hand-#context.scoring_hand) == 1 -- Only one unscored card / able to change to all by just removing this line
        and not context.blueprint then 
            local Queen_found = false
            for _, v in ipairs (context.scoring_hand) do
                if v:get_id() == 12 and not v.debuff then
                    Queen_found = true
                    break
                end
            end
            if Queen_found and not card.ability.extra.stoned then
                context.other_card:set_ability(G.P_CENTERS["m_stone"],false,1)
                -- add a SFX medusa shout
                juice_card(context.other_card)
                card.ability.extra.stoned = true
            end
        elseif context.end_of_round then
            card.ability.extra.stoned = false
        end
    end
}
