SMODS.Joker {
    key = "bigrock",
    atlas = 'wjokers',
    pos = { x = 5, y = 0 },

    config = {
        extra = {
            odds = 2
        }
    },
    
    rarity = 3, 
    cost = 7,
    
    unlocked = true,
    discovered = true,
    eternal_compat = false,

    blueprint_compat = false,

    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local numerator, denominator = 
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'caillou')
        return{
            vars = {
                numerator,
                denominator
            }
        }
    end,


    calculate = function(self,card,context)
        if context.before and (SMODS.find_card(self.key)[1] == card) and #context.scoring_hand == 5 and not context.blueprint then 
            local cards = {}
            for _, k in ipairs(context.scoring_hand) do 
                if not SMODS.has_enhancement(k,'m_stone') then
                    return            
                else
                    table.insert(cards, k)
                end
            end
            SMODS.destroy_cards(cards)

            G.GAME.chips = G.GAME.blind.chips
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    if SMODS.pseudorandom_probability(card, "caillou", 1, card.ability.extra.odds) then
                        -- SFX Rock breaking
                        SMODS.calculate_effect({message = "Break!", colour = HEX("808080")}, card)
                        SMODS.destroy_cards(card)
                    else
                        SMODS.calculate_effect({message = "Keep Mining!", colour = HEX("808080")}, card)
                    end
                    return true
                end
            }))
            
            return {
                --SFX Rock Smashing the ground
                message = 'CRUSHED!',
                colour = HEX('808080')
            }
        end
    end,

    in_pool = function(self, args) 
        local stone_cpt = 0
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                stone_cpt = stone_cpt + 1
            end
        end
        if stone_cpt >= 5 then return true else return false end
    end
}