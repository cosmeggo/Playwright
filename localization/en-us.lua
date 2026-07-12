return {
    descriptions = { -- Backs start below
        Back = {
            b_pw_dramaturgy = {
                name = "Dramaturgy Deck",
                text = {
                    "{B:1,V:2}Playwright{} Jokers",
                    "may appear in store"
                },
            },
        }, -- Jokers start below
        Joker = { -- COMEDY
            j_pw_rosalind = {
                name = "Rosalind",
                text = {
                    "Earn {C:money}$#1#{} if Blind",
                    "is cleared in {C:attention}one hand{}",
                },
            },
            j_pw_tiefling = {
                name = "Mielli Fogthorne",
                text = {
                    "Earn {C:money}$#1#{} if",
                    "played hand contains",
                    "a {C:attention}Flush{} of {V:1}#2#s{}",
                    "{C:inactive}(Suit changes every round){}",
                },
            },
            j_pw_krystal = {
                name = "Krystal",
                text = {
                    "{C:spectral}Spectral{} cards may",
                    "appear in the shop",
                },
            },
            j_pw_princezam = {
                name = "Princezam",
                text = {
                    "If played hand contains every {C:attention}suit{}",
                    "convert all played cards to a",
                    "single random {C:attention}suit{}",
                },
            },
            j_pw_aislin = {
                name = "Aislin",
                text = {
                    "{C:green}#1# in #2#{} for each",
                    "played card to",
                    "{C:attention}increase{} in rank"
                },
            },
            j_pw_harvey = {
                name = "Harvey",
                text = {
                    "Gain {C:money}$#1#{} in {C:attention}sell value{}",
                    "per {C:attention}destroyed card{}",
                },
            },
            j_pw_hayden = {
                name = "Hayden",
                text = {
                    "Create a {C:spectral}Spectral{} card",
                    "if hand contains only",
                    "{C:attention}Enhanced cards{}",
                    "{C:inactive}(Must have room)",
                },
            },
            j_pw_sunshine = {
                name = "SUNSHINE",
                text = {
                    "{C:attention}Comedy Jokers{} each",
                    "give {C:money}$#1#{} when hand is",
                    "scored"
                },
            },
            j_pw_amri = {
                name = "Amri",
                text = {
                    {
                    "Gain {C:attention}+#1#{} hand size",
                    "per {C:tarot}Tarot{} used",
                    },
                    {
                    "Resets when {C:attention}Boss",
                    "{C:attention}Blind{} is defeated"
                    }
                },
            },
            j_pw_twain = {
                name = "Cassandra Twain",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Payout increases by {C:money}$#3#{} if",
                    "played hand contains a",
                    "{C:attention}#2#{}"
                },
            },
            j_pw_aurora = {
                name = "Aurora",
                text = {
                    "If {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card, apply a",
                    "{C:attention}random seal{} to it",
                },
            },
            j_pw_ember = {
                name = "Ember",
                text = {
                    "Lose {C:money}$#1#{} at end of round",
                    "Gain {C:money}$#1#{} in {C:attention}sell value{}",
                },
            },
            j_pw_teagan = {
                name = "Teagan",
                text = {
                    "At the end of round,",
                    "earn {C:money}$#1#{} for each",
                    "empty {C:attention}Joker{} slot",
                    "{C:inactive,s:0.8}(Teagan included)",
                },
            },
            j_pw_dee = {
                name = "Dee",
                text = {
                    "Played {C:diamonds}Diamonds{} have a {C:green}#1# in #2#{}",
                    "chance of creating a {C:dark_edition}Negative{} {C:tarot}Tarot{}",
                },
            },
            j_pw_vivi = {
                name = "Vivi",
                text = {
                    "When {C:attention}Blind{} is cleared",
                    "gain a random {C:attention}Tag{}",
                },
            },
            j_pw_goblingal = { -- MYSTERY
                name = "Goblin Gal",
                text = {
                    "Retrigger each",
                    "played {C:attention}Mult Card{}",
                },
            },
            j_pw_melody = {
                name = "Melody",
                text = {
                    "Played cards each give {X:mult,C:white}X#1#{} Mult",
                    "if all cards held in hand are {C:hearts}Hearts{}",
                },
            },
            j_pw_phoenix = {
                name = "Phoenix",
                text = {
                    "Gain {X:mult,C:white}X#2#{} Mult",
                    "per {C:attention}Mult Card{} scored",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_pw_myron = {
                name = "Myron von Graves",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played",
                    "hand contains only {C:attention}#2#{} cards",
                },
            },
            j_pw_nadia = {
                name = "Nadia",
                text = {
                    "Played {C:attention}Steel Cards{}",
                    "give {C:red}+#1#{} Mult",
                },
            },
            j_pw_bubbs = {
                name = "Bubbs",
                text = {
                    "Played {C:attention}Wild Cards{}",
                    "permanently gain {C:red}+#1#{} Mult",
                },
            },
            j_pw_ellie = {
                name = "Ellie 1.0",
                text = {
                    "Gain {X:mult,C:white}X#2#{} Mult for",
                    "each {C:attention}enhanced{} card in deck",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                },
            },
            j_pw_sirius = {
                name = "Sirius",
                text = {
                    "Played {C:attention}10s{} have a",
                    "{C:green}#1# in #2#{} chance of",
                    "becoming {C:dark_edition}Holographic{}"
                },
            },
            j_pw_isaac = {
                name = "Issac", -- (sic)
                text = {
                    "{X:mult,C:white}X#1#{} Mult per",
                    "held {C:attention}consumable{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_pw_milk = {
                name = "MILK",
                text = {
                    "{C:red}Mystery Jokers{} each",
                    "give {X:mult,C:white}X#1#{} Mult",
                },
            },
            j_pw_rosha = {
                name = "Rosha",
                text = {
                    {
                    "Gain {C:red}+#2#{} Mult per",
                    "{C:attention}face card{} discarded",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
                    },
                    {
                    "Resets when {C:attention}Boss",
                    "{C:attention}Blind{} is defeated"
                    }
                },
            },
            j_pw_lullek = {
                name = "Lullek",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand",
                    "contains only {C:attention}Kings{}",
                },
            },
            j_pw_penpal = {
                name = "Penpal",
                text = {
                    "{C:attention}Lucky Cards{} are",
                    "{C:green}guaranteed{} to trigger"
                },
            },
            j_pw_hazel = {
                name = "Hazel",
                text = {
                    "Gain {C:red}+#2#{} Mult",
                    "if played hand",
                    "contains a {C:attention}Flush{}",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
                },
            },
            j_pw_oliver = {
                name = "Oliver Smith",
                text = {
                    "Played {C:attention}Glass Cards{} give",
                    "an additional {X:mult,C:white}X#1#{} Mult",
                    "but are {C:red}guaranteed{} to break",
                },
            },
            j_pw_aux = { -- TRAGEDY
                name = "Aux",
                text = {
                    "Earn {C:blue}+#2#{} Chips per card",
                    "{C:attention}purchased{} this run",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)",
                },
            },
            j_pw_somnia = {
                name = "Somnia",
                text = {
                    "If final hand of round has",
                    "only {C:attention}1{} card, destroy it",
                    "and gain {X:chips,C:white}X#2#{} Chips",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                },
            },
            j_pw_void = {
                name = "Void",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "for played {C:clubs}Clubs{} to",
                    "become {C:attention}Stone Cards{}"
                },
            },
            j_pw_lana = {
                name = "Lana",
                text = {
                    "{C:blue}+#1#{} Chips if",
                    "{C:attention}no discards{} are",
                    "used this round"
                },
            },
            j_pw_onyx = {
                name = "Onyx",
                text = {
                    "{X:chips,C:white}X#1#{} Chips if",
                    "{C:attention}played hand{}",
                    "contains {C:attention}only{}",
                    "{C:spades}Spades{}"
                },
            },
            j_pw_kennedy = {
                name = "Kennedy",
                text = {
                    "At the end of round,",
                    "{C:attention}upgrade{} a {C:green}random{}",
                    "{C:attention}poker hand{}"
                },
            },
            j_pw_kotaro = {
                name = "Koutarou",
                text = {
                    "{C:blue}+#1#{} Chips per {C:spectral}Spectral{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:blue}+#2#{C:inactive} Chips)",
                },
            },
            j_pw_sapphire = {
                name = "Sapphire",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                    "{X:chips,C:white}-X#2#{} Chips",
                    "per {C:planet}Planet{} card used",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                },
            },
            j_pw_luna = {
                name = "LUNA",
                text = {
                    "{C:planet}Tragedy Jokers{} each",
                    "give {X:chips,C:white}X#1#{} Chips",
                },
            },
            j_pw_loner = {
                name = "Loner",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "create a {C:dark_edition}Negative{}",
                    "{C:planet}Planet{} card when",
                    "{C:attention}rerolling{}"
                },
            },
            j_pw_kirin = {
                name = "Kirin",
                text = {
                    "{C:blue}+#1#{} Chips in the",
                    "{C:attention}first hand of round{}",
                },
            },
            j_pw_adelina = {
                name = "Adelina",
                text = {
                    "Gain {C:blue}+#2#{} Chips per",
                    "card {C:attention}Enhancement{} removed",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)",
                },
            },
            j_pw_berry = {
                name = "Berry",
                text = {
                    "{C:attention}Upgrade{} a random",
                    "{C:attention}poker hand{} by {C:attention}#1#{}",
                    "levels if {C:aattention}no purchases{}",
                    "are made in shop"
                },
            },
            j_pw_saorise = {
                name = "Saorise",
                text = {
                    "Gain {X:chips,C:white}X#2#{} Chips",
                    "if played hand contains",
                    "only {C:attention}Aces{}",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                },
            },
            j_pw_pitter = {
                name = "Pitter",
                text = {
                    {
                    "{C:chips}+#1#{} Chips if",
                    "played hand does not",
                    "contain a {C:attention}#2#{}",
                    },
                    {
                    "{C:inactive}(Poker hand changes{}",
                    "{C:inactive}at end of round){}",
                    }
                },
            },
            j_pw_wormston = {
                name = "Wormston",
                text = {
                    "When {C:attention}Blind{} is selected",
                    "Create a {C:dark_edition}Negative{}",
                    "{B:1,V:2}Playwright{} Joker",
                },
            },
        }, -- Other starts below
        Other = {
            p_pw_comedy_pack = {
                name = "Comedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:attention} Comedy{} Jokers",
                },
            },
            p_pw_mystery_pack = {
                name = "Mystery Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:red} Mystery{} Jokers",
                },
            },
            p_pw_tragedy_pack = {
                name = "Tragedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:planet} Tragedy{} Jokers",
                },
            },
        }
    },
    misc = {
        challenge_names = {
            c_pw_diamant = "Diamant Disorder",
            c_pw_visser = "Visser Vice",
        },
    },
    dictionary = {
        k_pw_comedy = "Comedy",
        k_pw_mystery = "Mystery",
        k_pw_tragedy = "Tragedy",
    },
    labels = {
        pw_comedy = "Comedy",
        pw_mystery = "Mystery",
        pw_tragedy = "Tragedy",
    },
}
