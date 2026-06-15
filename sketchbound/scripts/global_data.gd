extends Node

var deck : Array[Card] = []
var _initial_deck = {
	PunchCard: 6,
	SpearCard: 1,
	ArrowCard: 2,
	SlashCard: 2,
	HammerCard: 1,
	NewCard: 5
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card_type in _initial_deck.keys():
		for i in range(_initial_deck[card_type]):
			deck.append(card_type.new())
