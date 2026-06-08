return{
    descriptions = {
        Joker = {
            j_whiteem_bigrock ={
                ['name'] = 'Big Rock',
                ['text'] = {
                    "If played hand is {C:attention}5 Stone Cards",
                    "{S:1.1,C:attention}win{} the round, {C:attention}destroy{} them",
                    "{C:green}#1# in #2#{} chance to {S:1.1,C:red,E:2}self-destruct{}",
                }
            },
            j_whiteem_galaxyrock = {
                ['name'] = "Galaxy Rock",
                ['text'] = {
                    "If played hand is a single ",
                    "{C:attention}Stone Card{}, destroy it and create a",
                    "{C:planet}Planet{} card for your {C:attention}most{} played hand",
                    "{C:inactive}(Must have room)",
                }
            },
            j_whiteem_hardrock ={
                ['name'] = 'Hard Rock',
                ['text']= {
                    "Played {C:attention}Stone Cards{}",
                    "gives {X:chips,C:white} X#1# {} Chips ",
                    "when scored",
                }
            },
            j_whiteem_balancingrock ={
                    ['name'] = 'Rock Balancing',
                    ['text']= {
                        "Gains {X:mult,C:white} X#1# {} Mult when a hand",
                        "is played with a {C:attention}Stone Card{} in it",
                        "resets when a hand without is played",
                        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    }
                },
            j_whiteem_ricochet ={
                ['name'] = 'Ricochet',
                ['text']= {
                    "{C:attention}Retriggers{} all {C:attention}Stone Cards{}",
                }
            },
            j_whiteem_champagne = {
                ['name'] = "Champagne Flute",
                ['text'] = {
                    "Retrigger played {C:attention}Glass Cards",
                    "{C:inactive}({C:attention}#1#{} {C:inactive}cards remaining)"
                }
            },
            j_whiteem_commonprint = {
                ['name'] = "Commonprint",
                ['text'] = {
                    "Copies ability of",
                    "a {C:blue}Common {C:attention}Joker{} to",
                    "the right {C:attention}twice{}"
                }
            },
            j_whiteem_flowerseeds = {
                ['name'] = "Flower Seeds",
                ['text'] = {
                    "This Joker gains",
                    "{C:mult}+#1#{} Mult when any",
                    "card changes {C:attention}suit{}",
                    "{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)",
                }
            },
            j_whiteem_inkblot ={
                ['name'] = "Ink Blot Joker",
                ['text'] = {
                    "Once per round, creates a copy of",
                    "{C:attention}1{} random {C:attention}consumable{} in your",
                    "possession if hand played is {C:attention}#1#{},",
                    "{s:0.8}poker hand changes each round",
                    "{C:inactive}(Must have room)"
                }
            },
            j_whiteem_iron = {
                ['name'] = 'Iron and Coal Joker',
                ['text'] = {
                    "Played {C:attention}Steel Cards",
                    "gives {C:chips}+#1#{} Chips",
                    "and {C:mult}+#2#{} Mult",
                    "when scored",
                }
            },
            j_whiteem_jelly = {
                ['name'] = "Eerie Jelly",
                ['text'] = {
                    "Adds {C:attention}1{} free {C:spectral}Spectral Pack",
                    "at start of shop", 
                    "{C:inactive}({C:attention}#1#{} {C:inactive}rounds remaining)",
                }
            },
            j_whiteem_jix = {
                ['name'] = "Jix Seven",
                ['text'] = {
                    "Retrigger all {C:attention}6{} and {C:attention}7",
                    "#1# additionnal times"
                }
            },
            j_whiteem_jungle = {
                ['name'] = 'Welcome to the Jungle',
                ['text'] = {
                    "If played hand contains",
                    "a {C:attention}#1#{} and a {C:attention}Wild Card{}",
                    "level up the poker hand played",
                }
            },
            j_whiteem_lucky7 = {
                ['name'] = "Lucky 7",
                ['text'] = {
                    "Played {C:attention}7s{} gives {C:money}$#1#",
                    "and {X:mult,C:white}X#2#{} Mult",
                    "{C:green}#3# in #4#{} chance to gain",
                    "{C:money}$#5#{} if a {C:attention}7{} scored",
                }
            },
            j_whiteem_mathcorrect = {
                ['name'] = "Mathematically Correct Joker",
                ['text'] = {
                    "{X:chips,C:white} X#1# {} Chips",
                    "{C:mult}#2#{} Mult",
                    "{C:inactive}(Mult cannot be less than 1)",
                }
            },
            j_whiteem_medusa = {
                ['name'] = "Medusa",
                ['text'] = {
                    "The {C:attention}first time{} that a played hand",
                    "contains a scoring {C:attention}Queen{} and",
                    "a single {C:attention}unscored{} card",
                    "turn it into a {C:attention}Stone Card",
                }
            },
            j_whiteem_melting = {
                ['name'] = 'Melting Joker',
                ['text'] = {
                    "Played {C:attention}Steel{} or {C:attention}Gold Card",
                    "gives {C:money}$#1#{} when scored and",
                    "turn into {C:attention}Stone Card{}",
                }
            },
            j_whiteem_old = {
                ['name'] = "Old Joker",
                ['text'] = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored",
                    "{s:0.8}suit changes at end of round"
                }
            },
            j_whiteem_rainbow = {
                ['name'] = "ROYGBIV",
                ['text'] = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand cointains {C:attention}5 Wild Cards{}",
                }
            },
            j_whiteem_shopdisplay = {
                ['name'] = "Shopping Display",
                ['text'] = {
                    "{C:attention}+1 Shop{}, {C:attention}Booster Pack{}",
                    "and {C:attention}Voucher Slot{} in Shop",
                    "but everything is {C:money}50%{} more expensive"
                }
            },
            j_whiteem_signature = {
                ['name'] = "Signature",
                ['text'] = {
                    "{C:chips}+#1#{} Chips for your",
                    "most played {C:attention}poker hand"
                }
            },
            j_whiteem_toofull = {
                ['name'] = 'Hands too Full',
                ['text'] = {
                    '{C:mult}+#1#{} Mult',
                    '{C:red}#2#{} consumable slot',
                }
            },
            j_whiteem_trashcan = {
                ['name'] = "Golden Trash Can",
                ['text'] = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:money}$#3#{} for each {C:attention}non-scoring",
                    "cards in each hand",
                }
            },
            j_whiteem_young = {
                ['name'] = "Young Joker",
                ['text'] = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:chips}+#1#{} Chips when scored",
                    "{s:0.8}suit changes at end of round"
                }
            },
            j_whiteem_philosopher = {
                ['name'] = "Philosopher's Stone",
                ['text'] = {
                    "{C:attention}Stone Cards{} are also",
                    "considered {C:attention}Gold Cards{}",
                }
            },
            j_whiteem_paintedrock = {
                ['name'] = "Painted Rock",
                ['text'] = {
                    "{C:attention}Stone Cards{} are also",
                    "considered {C:attention}Wild Cards{}",
                }
            },
        }
    },

    Other = {
        undiscovered_uno ={
            name = 'Not Discovered',
            text = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does",
                },
        }

    },
    misc = {
        dictionary = {
            k_uno = "Uno",
            b_uno_cards = "Uno Cards",

            p_uno_pack = "Uno Cards Pack",
            p_whiteem_uno_pack = "Uno Cards Pack"
        },
        labels ={
            uno = "Uno"
        }

    }
}