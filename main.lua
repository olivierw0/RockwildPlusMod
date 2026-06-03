--#region Atlases

SMODS.Atlas {
    key = 'wjokers',
    path = 'wjokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'others',
    path = 'others.png',
    px = 71,
    py = 95
}
--#endregion 

--#region File Loading
local mod = SMODS.current_mod

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
local decks_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/backs")
local consumables_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/consumables")
local boosters_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/boosters")

for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("src/backs/" .. file))()
end

for _, file in ipairs(consumables_src) do
    assert(SMODS.load_file("src/consumables/" .. file))()
end

for _, file in ipairs(boosters_src) do
    assert(SMODS.load_file("src/boosters/" .. file))()
end
--#endregion


local function reset_old_card()
	local old_suits = {}
    G.GAME.current_round.old_card = G.GAME.current_round.old_card or {}
	for k, suit in pairs(SMODS.Suits) do
		if
			k ~= G.GAME.current_round.old_card.suit
			and (type(suit.in_pool) ~= "function" or suit:in_pool({ rank = "" }))
		then
			old_suits[#old_suits + 1] = k
		end
	end
	local old_card = pseudorandom_element(old_suits, pseudoseed("tux" .. G.GAME.round_resets.ante))
	G.GAME.current_round.old_card.suit = old_card
end

local function reset_young_card()
	local young_suits = {}
    G.GAME.current_round.young_card = G.GAME.current_round.young_card or {}
	for k, suit in pairs(SMODS.Suits) do
		if
			k ~= G.GAME.current_round.young_card.suit
			and (type(suit.in_pool) ~= "function" or suit:in_pool({ rank = "" }))
		then
			young_suits[#young_suits + 1] = k
		end
	end
	local young_card = pseudorandom_element(young_suits, pseudoseed("tux" .. G.GAME.round_resets.ante))
	G.GAME.current_round.young_card.suit = young_card
end

mod.reset_game_globals = function(run_start)
    reset_young_card()
    reset_old_card()
end