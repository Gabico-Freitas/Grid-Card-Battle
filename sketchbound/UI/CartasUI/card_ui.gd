extends Node
class_name Card_Ui

var card_id = 0
var pos_hand: int

signal card_selected(card_pos: String);

func set_up(id: int, pos: int) -> void:
	card_id = id
	pos_hand = pos
	
func _on_pressed() -> void:
	var card_selected_var = "SelectCard" + str(card_id)
	card_selected.emit(card_selected_var)
