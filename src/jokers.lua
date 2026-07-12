-- Comedy Jokers ↴

-- Rosalind
SMODS.Joker {
    key = "rosalind",
    config = { extra = { dollars = 4 } },
    pos = { x = 0, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.end_of_round and not context.blueprint and G.GAME.current_round.hands_played == 1 then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- Roulette Functions (taken from Hatchet)

local function reset_vremade_roulette_card()
    G.GAME.current_round.vremade_roulette_card = { suit = 'Spades' }
    local valid_roulette_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_roulette_cards[#valid_roulette_cards + 1] = playing_card
        end
    end
    local roulette_card = pseudorandom_element(valid_roulette_cards,
        'j_pw_tiefling' .. G.GAME.round_resets.ante)
    if roulette_card then
        G.GAME.current_round.vremade_roulette_card.suit = roulette_card.base.suit
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_vremade_roulette_card()
end

-- Pink Tiefling
SMODS.Joker {
    key = "tiefling",
    config = { extra = { dollars = 8 } },
    pos = { x = 1, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.vremade_roulette_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.dollars, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and next(context.poker_hands['Flush']) then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if not v:is_suit(G.GAME.current_round.vremade_roulette_card.suit) then
                    passed = false
                end
            end
            if passed then
                return {
                    dollars = card.ability.extra.dollars,
                    delay = 0.45
                }
            end
        end
    end
}

-- Krystal
SMODS.Joker {
    key = "krystal",
    config = { extra = { spectral_rate = 2 } },
    pos = { x = 2, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.spectral_rate } }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.spectral_rate = card.ability.extra.spectral_rate
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.spectral_rate = 0
    end,
}

-- Princezam
SMODS.Joker {
    key = "princezam",
    pos = { x = 3, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            if suits["Hearts"] > 0 and
                suits["Diamonds"] > 0 and
                suits["Spades"] > 0 and
                suits["Clubs"] > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                for i = 1, #context.full_hand do
                    local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    local target = context.full_hand[i]
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            target:flip()
                            play_sound('card1', percent)
                            target:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                local _suit = pseudorandom_element(SMODS.Suits, 'vremade_sigil')
                for i = 1, #context.full_hand do
                    local target = context.full_hand[i]
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = target
                            assert(SMODS.change_base(_card, _suit.key))
                            return true
                        end
                    }))
                end
                for i = 1, #context.full_hand do
                    local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    local target = context.full_hand[i]
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            target:flip()
                            play_sound('tarot2', percent, 0.6)
                            target:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                delay(0.5)
            end
        end
    end,
}

-- Aislin
SMODS.Joker {
    key = "aislin",
    config = { extra = { odds = 4 } },
    pos = { x = 4, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_pw_aislin')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'j_pw_aislin', 1, card.ability.extra.odds) and not context.blueprint then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.modify_rank(scored_card, 1)
                    scored_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                delay = 0.4
            }
        end
    end
}

-- Harvey
SMODS.Joker {
    key = "harvey",
    config = { extra = { price = 1 } },
    pos = { x = 5, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price * #context.removed
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

-- Hayden
SMODS.Joker {
    key = "hayden",
    pos = { x = 6, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if not next(SMODS.get_enhancements(v)) then
                    passed = false
                end
            end
            if passed and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'pw_hayden'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
}

-- Amri
SMODS.Joker {
    key = "amri",
    config = { extra = { h_size = 0, h_mod = 1 } },
    pos = { x = 8, y = 0 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_mod } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
            card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
            G.hand:change_size(card.ability.extra.h_mod)
            return {
                message = localize('k_upgrade_ex'),
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.h_size > 1 then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.h_size = 0
                return {
                    message = localize('k_reset'),
                }
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
        card.ability.extra.h_size = 0
    end
}

-- Cassandra Twain
SMODS.Joker {
    key = "twain",
    config = { extra = { dollars = 1, increase = 1 } },
    pos = { x = 0, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, localize('Four of a Kind', 'poker_hands'), card.ability.extra.increase } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Four of a Kind']) then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.increase
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}

-- Aurora
SMODS.Joker {
    key = "aurora",
    pos = { x = 1, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            local pcard = context.full_hand[1]
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local seal_pool = { 'Gold', 'Red', 'Blue', 'Purple' }
                    local random_seal = pseudorandom_element(seal_pool, pseudoseed('random_seal'))
                    pcard:set_seal(random_seal, nil, true)
                    return true
                end
            }))

            delay(0.5)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
        end
    end
}

-- Ember
SMODS.Joker {
    key = "ember",
    config = { extra = { money = 5 } },
    pos = { x = 2, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
            card:set_cost()
            return {
                dollars = -card.ability.extra.money,
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

-- Teagan
SMODS.Joker {
    key = "teagan",
    config = { extra = { dollars = 2 } },
    pos = { x = 3, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            return {
                dollars = math.max(1,
                        (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_pw_teagan", true))
                    * card.ability.extra.dollars
            }
        end
    end
}

-- Dee
SMODS.Joker {
    key = "dee",
    config = { extra = { odds = 4, tarot = 1 } },
    pos = { x = 4, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_pw_dee')
        return { vars = { numerator, denominator, card.ability.extra.tarot } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            if SMODS.pseudorandom_probability(card, 'j_pw_dee', 1, card.ability.extra.odds) then
                return {
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Tarot',
                                edition = 'e_negative'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                }
            end
        end
    end
}

-- Vivi
SMODS.Joker {
    key = "vivi",
    config = { extra = { tags = 1 } },
    pos = { x = 5, y = 1 },
    cost = 7,
    rarity = "pw_comedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.tags } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            add_tag({ key = get_next_tag_key(self.key) })
        end
    end
}

-- SUNSHINE
SMODS.Joker {
    key = "sunshine",
    config = { extra = { dollars = 5 } },
    pos = { x = 7, y = 0 },
    soul_pos = { x = 1, y = 5 },
    cost = 7,
    rarity = 4,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("pw_comedy") then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- Mystery Jokers ↴

-- Goblin Gal
SMODS.Joker {
    key = "goblingal",
    config = { extra = { repetitions = 1 } },
    pos = { x = 6, y = 1 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

-- Melody
SMODS.Joker {
    key = "melody",
    config = { extra = { xmult = 1.5 } },
    pos = { x = 7, y = 1 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local hearts = true
            for _, playing_card in ipairs(G.hand.cards) do
                if not playing_card:is_suit('Hearts', nil, true) then
                    hearts = false
                    break
                end
            end
            if hearts then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Phoenix
SMODS.Joker {
    key = "phoenix",
    config = { extra = { xmult = 1, xmult_gain = 0.1 } },
    pos = { x = 8, y = 1 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_mult') then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Myron von Graves
SMODS.Joker {
    key = "myron",
    config = { extra = { xmult = 4, size = 2 } },
    pos = { x = 0, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.size } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == card.ability.extra.size then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Nadia
SMODS.Joker {
    key = "nadia",
    config = { extra = { mult = 10 } },
    pos = { x = 1, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_steel') then
            return { mult = card.ability.extra.mult }
        end
    end
}

-- Bubbs
SMODS.Joker {
    key = "bubbs",
    config = { extra = { mult = 1 } },
    pos = { x = 2, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_wild') then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
                card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
    end
}

-- Ellie 1.0
SMODS.Joker {
    key = "ellie",
    config = { extra = { xmult = 1, xmult_gain = 0.25 } },
    pos = { x = 3, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local enhancement_tally = 0
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(v)) then enhancement_tally = enhancement_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.xmult + (card.ability.extra.xmult_gain * enhancement_tally) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local enhancement_tally = 0
            for _, v in ipairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) then enhancement_tally = enhancement_tally + 1 end
            end
            return {
                xmult = card.ability.extra.xmult + (card.ability.extra.xmult_gain * enhancement_tally)
            }
        end
    end
}

-- Sirius
SMODS.Joker {
    key = "sirius",
    config = { extra = { odds = 4 } },
    pos = { x = 4, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pw_sirius')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context) -- code by Somethingcom515
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 and
            SMODS.pseudorandom_probability(card, 'pw_sirius', 1, card.ability.extra.odds) then
            context.other_card:set_edition('e_holo', nil, true)
            local other_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    other_card:juice_up()
                    return true
                end
            }))
        end
    end
}

-- Isaac
SMODS.Joker {
    key = "isaac",
    config = { extra = { xmult = 1, xmult_gain = 0.5 } },
    pos = { x = 5, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    -- Code taken from Art Gallery (Ortalab)
    loc_vars = function(self, info_queue, card)
        local consumables = (G.consumeables and #G.consumeables.cards or 0)
        return { vars = { card.ability.extra.xmult_gain, (card.ability.extra.xmult_gain * consumables) + card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local consumables = #G.consumeables.cards
            return {
                xmult = card.ability.extra.xmult + (consumables * card.ability.extra.xmult_gain)
            }
        end
    end
}

-- Rosha
SMODS.Joker {
    key = "rosha",
    config = { extra = { mult = 0, mult_gain = 4 } },
    pos = { x = 7, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_face() then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.mult > 0 then
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Lullek
SMODS.Joker {
    key = "lullek",
    config = { extra = { xmult = 3 } },
    pos = { x = 8, y = 2 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if v:get_id() ~= 13 then
                    passed = false
                end
            end
            if passed then
                return { xmult = card.ability.extra.xmult }
            end
        end
    end
}

-- Penpal
SMODS.Joker {
    key = "penpal",
    pos = { x = 0, y = 3 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = {} }
    end,

    calculate = function(self, card, context) -- code by Somethingcom515
        if context.fix_probability and (context.identifier == 'lucky_mult' or context.identifier == 'lucky_money') then
            return { numerator = context.denominator }
        end
    end
}

-- Hazel
SMODS.Joker {
    key = "hazel",
    config = { extra = { mult = 0, mult_gain = 2 } },
    pos = { x = 1, y = 3 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and next(context.poker_hands['Flush']) then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Oliver Smith
SMODS.Joker {
    key = "oliver",
    config = { extra = { xmult = 1.5 } },
    pos = { x = 2, y = 3 },
    cost = 7,
    rarity = "pw_mystery",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context) -- code by Somethingcom515
        if context.fix_probability and (context.identifier == 'glass') then
            return { numerator = 4 }
        end
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_glass') then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

-- MILK
SMODS.Joker {
    key = "milk",
    config = { extra = { xmult = 1.5 } },
    pos = { x = 6, y = 2 },
    soul_pos = { x = 2, y = 5 },
    cost = 7,
    rarity = 4,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("pw_mystery") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Tragedy Jokers ↴

-- Aux
SMODS.Joker {
    key = "aux",
    config = { extra = { chips = 0, chips_gain = 4 } },
    pos = { x = 3, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,

    calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Somnia
SMODS.Joker {
    key = "somnia",
    config = { extra = { xchips = 1, xchips_gain = 0.2 } },
    pos = { x = 4, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1]
                and G.GAME.current_round.hands_left == 0 then
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.BLUE,
                    remove = true
                }
            end
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

-- Void
SMODS.Joker {
    key = "void",
    config = { extra = { odds = 2 } },
    pos = { x = 5, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pw_void')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") and
            SMODS.pseudorandom_probability(card, 'pw_void', 1, card.ability.extra.odds) then
            context.other_card:set_ability('m_stone', nil, true)
            local other_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    other_card:juice_up()
                    return true
                end
            }))
        end
    end
}

-- Lana
SMODS.Joker {
    key = "lana",
    config = { extra = { chips = 200 } },
    pos = { x = 6, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Onyx
SMODS.Joker {
    key = "onyx",
    config = { extra = { xchips = 3 } },
    pos = { x = 7, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if not v:is_suit("Spades") then
                    passed = false
                end
            end
            if passed then
                return { xchips = card.ability.extra.xchips }
            end
        end
    end
}

-- Kennedy
SMODS.Joker {
    key = "kennedy",
    pos = { x = 8, y = 3 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {} -- Code taken from Scorecard (All in Jest)
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands + 1] = k end
            end
            local hand = pseudorandom_element(_poker_hands, pseudoseed('pw_kennedy'))
            return {
                message = localize('k_level_up_ex'),
                level_up = 1,
                level_up_hand = hand
            }
        end
    end
}

-- Koutarou
SMODS.Joker {
    key = "kotaro",
    config = { extra = { chips = 30 } },
    pos = { x = 0, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)
            }
        end
    end,
}

-- Sapphire
SMODS.Joker {
    key = "sapphire",
    config = { extra = { xchips = 3, xchips_sub = 0.5 } },
    pos = { x = 1, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_sub } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Planet"
            and card.ability.extra.xchips - card.ability.extra.xchips_sub <= 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize('k_extinct_ex'),
                colour = G.C.CHIPS
            }
        else
            if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Planet" then
                card.ability.extra.xchips = card.ability.extra.xchips - card.ability.extra.xchips_sub
                return {
                    message = localize { type = 'variable', key = 'a_chips_minus', vars = { card.ability.extra.xchips_sub } },
                    colour = G.C.CHIPS
                }
            end
            if context.joker_main then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end,
}

-- Loner
SMODS.Joker {
    key = "loner",
    config = { extra = { odds = 4 } },
    pos = { x = 3, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pw_loner')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.reroll_shop and SMODS.pseudorandom_probability(card, 'j_pw_loner', 1, card.ability.extra.odds) then
            return {
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Planet',
                            edition = 'e_negative'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            }
        end
    end
}

-- Kirin
SMODS.Joker {
    key = "kirin",
    config = { extra = { chips = 200 } },
    pos = { x = 4, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Adelina
SMODS.Joker {
    key = "adelina",
    config = { extra = { chips = 0, chips_gain = 40 } },
    pos = { x = 5, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,

    calculate = function(self, card, context)
        if context.setting_ability and G.P_CENTERS[context.old].set == 'Enhanced' and G.P_CENTERS[context.new].set ~= 'Enhanced' then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Berry
SMODS.Joker {
    key = "berry",
    config = { extra = { levels = 2, reward = true } },
    pos = { x = 6, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.reward } }
    end,

    calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.reward = false
        end
        if context.ending_shop then
            if card.ability.extra.reward then
                local _poker_hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if v.visible then _poker_hands[#_poker_hands + 1] = k end
                end
                local hand = pseudorandom_element(_poker_hands, pseudoseed('pw_berry'))
                return {
                    message = localize('k_level_up_ex'),
                    level_up = card.ability.extra.levels,
                    level_up_hand = hand
                }
            end
        end
    end
}

-- Saorise
SMODS.Joker {
    key = "saorise",
    config = { extra = { xchips = 1, xchips_gain = 0.5 } },
    pos = { x = 7, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if v:get_id() ~= 14 then
                    passed = false
                end
            end
            if passed then
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
                return {
                    xchips = card.ability.extra.xchips,
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                }
            end
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

-- Pitter
SMODS.Joker {
    key = "pitter",
    config = { extra = { chips = 250, poker_hand = 'High Card' } },
    pos = { x = 8, y = 4 },
    cost = 7,
    rarity = "pw_tragedy",
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name ~= card.ability.extra.poker_hand then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'pw_pitter')
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'pw_pitter')
    end
}

-- LUNA
SMODS.Joker {
    key = "luna",
    config = { extra = { xchips = 1.5 } },
    pos = { x = 2, y = 4 },
    soul_pos = { x = 3, y = 5 },
    cost = 7,
    rarity = 4,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("pw_tragedy") then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
}


-- Wormston ↴

-- WORM
SMODS.Joker {
    key = "wormston",
    config = { extra = { creates = 1 } },
    pos = { x = 0, y = 5 },
    soul_pos = { x = 4, y = 5 },
    cost = 7,
    rarity = 4,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PWJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { 'PWBG', 'PWTXT', colours = { HEX('2c2c2c'), HEX('fdfdcb') } } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            local jokers_to_create = card.ability.extra.creates
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    local pwjokers = { 'pw_comedy', 'pw_mystery', 'pw_tragedy' }
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = pseudorandom_element(pwjokers, "pw_wormston"),
                            edition = 'e_negative',
                            key_append = 'pw_wormston'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.PURPLE,
            }
        end
    end
}
