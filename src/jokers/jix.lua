SMODS.Joker{
    key = "jix",
    atlas = "wjokers",
    pos = { x = 2, y = 2 },
    soul_pos = { x = 2, y = 3 },

    config = {
        extra = {
            reps = 2
        }
    },

    loc_txt = {
        ['name'] = "Jix Seven",
        ['text'] = {
            "Retrigger all {C:attention}6{} and {C:attention}7",
            "#1# additionnal times"
        }
    },

    rarity = 4,
    cost = 20,

    unlocked = true,
    discovered = true,

    loc_vars = function (self,info_queue,card)
        return{
            vars = {
                card.ability.extra.reps
            }
    } 
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and 
        (context.other_card:get_id() == 6 or context.other_card:get_id() == 7) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.reps,
                card = card
            }
        elseif context.repetition and context.cardarea == G.hand and 
        (context.other_card:get_id() == 6 or context.other_card:get_id() == 7) then
            if (next(context.card_effects[1]) or #context.card_effects > 1) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.reps,
                    card = card
                }
            end
        end 
    end

}