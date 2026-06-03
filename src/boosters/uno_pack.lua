-- Uno Booster Packs
SMODS.Booster {
    key = "uno_1",
    weight = 0.5,
    kind = 'uno_Pack',
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 },
    group_key = "k_uno_pack",
    draw_hand = true,
    
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
            },
            key = self.key:sub(1, -3)
        }
    end,
    
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.RED, lighten(G.C.RED, 0.4), lighten(G.C.BLACK, 0.2), lighten(G.C.WHITE, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    
    create_card = function(self, card, i)
        -- All possible uno cards
        local uno_cards = {
            'c_whiteem_plus_two',
            'c_whiteem_reverse',
            'c_whiteem_skip',
            'c_whiteem_wild',
            'c_whiteem_wild4'
        }
        
        local _card = {
            set = "Uno",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key = uno_cards[math.random(#uno_cards)]
        }
        return _card
    end,
}