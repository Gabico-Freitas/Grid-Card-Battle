extends Node

var current_level := 1
var deck : Array[Card] = []
var _initial_deck = {
	PunchCard: 6,
	SpearCard: 1,
	ArrowCard: 2,
	SlashCard: 2,
	HammerCard: 1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card_type in _initial_deck.keys():
		for i in range(_initial_deck[card_type]):
			deck.append(card_type.new())

func next_level() -> void:
	current_level += 1
	print(current_level)
	
	match current_level:
		2:
			get_tree().change_scene_to_file("res://level_2.tscn")
		3: 
			get_tree().change_scene_to_file("res://level_3.tscn")
		_:
			get_tree().change_scene_to_file("res://UI/win_screen.tscn")
