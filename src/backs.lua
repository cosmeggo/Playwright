-- Dramaturgy Deck
SMODS.Back {
    key = 'dramaturgy',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'PWDecks',

    loc_vars = function(self, info_queue, back)
        return { vars = { 'PWBG', 'PWTXT', colours = { HEX('2c2c2c'), HEX('fdfdcb') } } }
    end,
}