-- Diamant Disorder
SMODS.Challenge {
    key = 'diamant',
    rules = {
        modifiers = {
            { id = 'discards', value = 1 },
        }
    },
    jokers = {
        { id = 'j_oops', edition = 'negative' },
        { id = 'j_oops', edition = 'negative' },
        { id = 'j_pw_aislin', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = '2' }, -- Spades
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'S', r = '2' },
            { s = 'H', r = '2' }, -- Hearts
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'H', r = '2' },
            { s = 'C', r = '2' }, -- Clubs
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' }, -- Diamonds
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
            { s = 'D', r = '2' },
        },
    },

    restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = { -- Booster Packs
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2', }
            },
            { id = 'j_dna' }, -- Jokers
            { id = 'j_marble' },
            { id = 'j_certificate' },
            { id = 'j_drunkard' },
            { id = 'j_merry_andy' },
            { id = 'c_tower' }, -- Tarots
            { id = 'c_strength' }, -- Tarots
            { id = 'v_magic_trick' }, -- Vouchers
            { id = 'v_illusion' },
            { id = 'v_wasteful' },
            { id = 'v_recyclomancy' },
            { id = 'c_incantation' }, -- Spectrals
            { id = 'c_grim' },
            { id = 'c_familiar' },
        },
        banned_tags = {
            { id = 'tag_standard' }, -- Tags
        }
    }
}

-- Visser Vice
SMODS.Challenge {
    key = 'visser',
    jokers = {
        { id = 'j_ceremonial', pinned = true, eternal = true },
        { id = 'j_joker', },
        { id = 'j_pw_harvey' },
    },
    consumeables = {
        { id = 'c_hanged_man' },
        { id = 'c_hanged_man' },
    },
}