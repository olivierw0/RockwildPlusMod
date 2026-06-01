SMODS.Joker {
    key = "commonprint",
    atlas = "wjokers",
    pos = { x = 4, y = 3 },

    loc_txt = {
        ['name'] = "Commonprint",
        ['text'] = {
            "Copies ability of",
            "a {C:attention}Common Joker{} to",
            "the right {C:attention}twice{}"
        }
    },

    rarity = 3,
    cost = 10,

    unlocked = true,
    discovered = true,

    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat and other_joker.config.center.rarity == 1
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return {
                main_end = main_end 
            }
        end
    end,

    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        local ret, ret2 = nil, nil

        if other_joker and other_joker:is_rarity('Common') then
            ret = SMODS.blueprint_effect(card, other_joker, context)
            ret2 = SMODS.blueprint_effect(card, other_joker, context)
        end

        if ret then
            return SMODS.merge_effects { ret, ret2 }
        end
    end
}