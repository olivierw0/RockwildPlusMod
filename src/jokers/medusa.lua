SMODS.Joker {
    key = 'medusa',
    atlas = 'wjokers',
    pos = { x = 3, y = 1},

    config = {
        extra = {
            stoned = false
        }
    },

    rarity = 2,
    cost = 6,
    

    blueprint_compat = false,
    unlocked = true,
    discovered = true,

    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
            card.ability.extra.stoned = false
            local eval = function() return not card.ability.extra.stoned end
            juice_card_until(card, eval, true)

        elseif context.before and not context.blueprint then
            
        elseif context.individual and context.cardarea == "unscored" 
        and (#context.full_hand-#context.scoring_hand) == 1 -- Only one unscored card / able to change to all by just removing this line
        and not context.blueprint
        then 
            local Queen_found = false
                for i = #context.scoring_hand,1,-1 do
                    if context.scoring_hand[i]:get_id() == 12 and not context.scoring_hand[i].debuff then
                        Queen_found = true
                        break
                    end
                end
                if Queen_found and not card.ability.extra.stoned and not context.blueprint then
                    context.other_card:set_ability(G.P_CENTERS["m_stone"],false,1)
                    card.ability.extra.stoned = true
                end
        elseif context.end_of_round then
            card.ability.extra.stoned = true
        end
    end
}
