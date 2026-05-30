return{
    descriptions = {
        Joker = {
            j_whiteem_jungle = {
                name = 'Welcome to the Jungle',
                text = {
                    "Played {C:attention}Wild Cards{}",
                    "gives {X:mult,C:white} X#1# {} Mult",
                    "when scored",
                }
            },
            j_whiteem_hardrock = {
                name = 'Hard Rock',
                text = {
                    "Played {C:attention}Stone Cards{}",
                    "gives {X:chips,C:white} X#1# {} Chips ",
                    "when scored",
                }
            }, 
            j_whiteem_iron = {
                name = 'Iron and Coal Joker',
                text = {
                    "Played {C:attention}Steel Cards",
                    "gives {C:chips}+#1#{} Chips",
                    "and {C:mult}+#2#{} Mult",
                    "when scored",
                }
            }, 
            j_whiteem_molten = {
                name = 'Melting Joker',
                text = {
                    "This Joker gives {C:money}$#1#{} per scoring",
                    "{C:attention}Steel{} or {C:attention}Gold Card{} played",
                    "and turn them into {C:attention}Stone Card{}",
                }
            }, 
            j_whiteem_rainbow = {
                name = "ROYGBIV",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand cointains 5 {C:attention}Wild Cards{}",
                }
            }, 
            j_whiteem_jackpot = {
                name = "Jackpot",
                text = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:money}$#3#{} and {X:mult,C:white} X#4# {} Mult when",
                    "scoring three {C:attention}7s{}",
                }
            }, 
            j_whiteem_flower_seeds = {
                name = "Flower Seeds",
                text = {
                    "This Joker gains",
                    "{C:mult}+#1#{} Mult when any",
                    "card changes {C:attention}suit{}",
                    "{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)",
                }
            },
            j_whiteem_trashcan = {
                name = "Golden Trash Can",
                text = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:money}$#3#{} for each {C:attention}non-scoring",
                    "cards in each hand",
                }
            },
            j_whiteem_medusa = {
                name = "Medusa",
                text = {
                    "The {C:attention}first time{} that a played hand",
                    "contains a {C:attention}Queen{} and",
                    "a single {C:attention}unscored{} card",
                    "turn it into a {C:attention}Stone Card",
                }
            },
            j_whiteem_jelly = {
                name = "Eerie Jelly",
                text = {
                    "Adds 1 free {C:attention}Spectral Pack",
                    "at start of shop", 
                    "{C:inactive}({C:attention}#1#{} {C:inactive}rounds remaining)",
                }
            },
            j_whiteem_young = {
                name = "Young Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:chips}+#1#{} Chips when scored",
                    "{s:0.8}suit changes at end of round"
                }
            },
            j_whiteem_old = {
                name = "Old Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored",
                    "{s:0.8}suit changes at end of round"
                }
            },
            j_whiteem_champagne = {
                name = "Champagne Flute",
                text = {
                    "Retriggers played {C:attention}Glass Cards",
                    "{C:inactive}({C:attention}#1#{} {C:inactive}cards remaining)"
                }
            },
            j_whiteem_jix = {
                name = "Jix Seven",
                text = {
                    "{C:attention}Retriggers{} all {C:attention}6{} and {C:attention}7",
                    "#1# additionnal times"
                }
            },
            j_whiteem_signature = {
                name = "Signature",
                text = {
                    "{C:chips}+#1#{} Chips for your",
                    "most played {C:attention}poker hand"
                }
            }
        },

        Back = {
            b_whiteem_belote = {
                name = "Bridge Deck",
                text = {
                    "Start run with",
                    "32 cards deck",
                    "4 cards {C:attention}selection{}",
                }
            },
        }
    }
}