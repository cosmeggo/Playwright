SMODS.Booster {
    key = "comedy_pack",
    weight = 0.6,
    cost = 4,
    pos = { x = 0, y = 0 },
    atlas = 'PWBoosters',
    loc_txt = {
        group_name = "Comedy Pack"
    },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f07432"))
        ease_background_colour({ new_colour = HEX('f07432'), special_colour = HEX("ffa442"), contrast = 2 })
    end,
    create_card = function(self, card, i)
        return { 
            set = "Joker",
            area = G.pack_cards, 
            rarity = "pw_comedy",
            skip_materialize = true, 
            soulable = true, 
            key_append = "pw_comp" } -- comp = comedy pack, mysp = mystery pack, trap = tragedy pack
    end,
}

SMODS.Booster {
    key = "mystery_pack",
    weight = 0.6,
    cost = 4,
    pos = { x = 1, y = 0 },
    atlas = 'PWBoosters',
    loc_txt = {
        group_name = "Mystery Pack"
    },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("db3b3b"))
        ease_background_colour({ new_colour = HEX('db3b3b'), special_colour = HEX("f0516c"), contrast = 2 })
    end,
    create_card = function(self, card, i)
        return { 
            set = "Joker",
            area = G.pack_cards, 
            rarity = "pw_mystery",
            skip_materialize = true, 
            soulable = true, 
            key_append = "pw_mysp" } -- comp = comedy pack, mysp = mystery pack, trap = tragedy pack
    end,
}

SMODS.Booster {
    key = "tragedy_pack",
    weight = 0.6,
    cost = 4,
    pos = { x = 2, y = 0 },
    atlas = 'PWBoosters',
    loc_txt = {
        group_name = "Tragedy Pack"
    },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("306468"))
        ease_background_colour({ new_colour = HEX('306468'), special_colour = HEX("71d5d9"), contrast = 2 })
    end,
    create_card = function(self, card, i)
        return { 
            set = "Joker",
            area = G.pack_cards, 
            rarity = "pw_tragedy",
            skip_materialize = true, 
            soulable = true, 
            key_append = "pw_trap" } -- comp = comedy pack, mysp = mystery pack, trap = tragedy pack
    end,
}