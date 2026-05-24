extends Button
class_name Card_Ui

@onready var player: Player
@onready var event: InputEvent

var card_data : Card
var pos_hand: int

signal card_selected(Card_Ui);

func _ready() -> void:
	focus_mode = Control.FOCUS_NONE

func setup(card: Card, pos: int):
	card_data = card
	pos_hand = pos

func set_card(card: Card) -> void:
	card_data = card

func set_pos(pos: int) -> void:
	pos_hand = pos

func _on_pressed() -> void:
	card_selected.emit(self)
