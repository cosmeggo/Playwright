-- Rarities

SMODS.Rarity {
    key = "pw_comedy",
    default_weight = 0.1,
    loc_txt = { name = "Comedy" },
    badge_colour = HEX('ec8650'),
	pools = { ["Joker"] = { rate = 0.1 } },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "pw_mystery",
    default_weight = 0.1,
    loc_txt = { name = "Mystery" },
    badge_colour = HEX('cb4f4f'),
	pools = { ["Joker"] = { rate = 0.1 } },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "pw_tragedy",
    default_weight = 0.1,
    loc_txt = { name = "Tragedy" },
    badge_colour = HEX('5b8c8a'),
	pools = { ["Joker"] = { rate = 0.1 } },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}