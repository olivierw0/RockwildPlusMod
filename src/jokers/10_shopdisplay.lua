SMODS.Joker{
    key='shopdisplay',
    atlas='wjokers',
    pos= { x = 0, y = 4 },

    config = {
        extra = {
            percent = -50
        }
    },

    rarity = 2,
    cost = 6,

    blueprint_compat = false,

    unlocked = true,
    discovered = true, 

    add_to_deck = function(self, card, from_debuff)
        change_shop_size(1)
        SMODS.change_voucher_limit(1)
        SMODS.change_booster_limit(1)
        
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-1)
        SMODS.change_voucher_limit(-1)
        SMODS.change_booster_limit(-1)

        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    calculate = function (self, card, context)
        if context.buying_card and context.card.ability.set == "Voucher" then
            if context.card.config.center.key == "v_clearance_sale" or context.card.config.center.key == "v_liquidation" then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.percent
                        for _, v in pairs(G.I.CARD) do
                            if v.set_cost then v:set_cost() end
                        end
                        return true
                    end
                }))
            end
        end
    end
}