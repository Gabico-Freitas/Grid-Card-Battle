extends CanvasLayer
class_name UI

@export var player: Player
@onready var hand_cards := $HandCards
@onready var control_screen := $ControlsScreen
@onready var player_healthbar := $StatusBox/PlayerHealthBarText
@onready var move_icons := $StatusBox/MoveFlowContainer
@onready var mana_icons := $StatusBox/ManaFlowContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_cards.player = player

func is_controls_screen_visible() -> bool:
	return control_screen.visible

func update_hand(player_hand : Array[Card]) -> void:
	hand_cards.update_hand(player_hand)

func _on_player_turn_ended() -> void:
	hand_cards._on_player_turn_ended()

func _on_player_damaged(value: int) -> void:
	player_healthbar._on_player_damaged(value)

func _on_player_moved(curr_moves: int, max_moves: int) -> void:
	move_icons._on_player_moved(curr_moves, max_moves)

func _on_player_mana_spent(curr_mana: int, max_mana: int) -> void:
	mana_icons._on_player_mana_spent(curr_mana, max_mana)

func set_text_button(text: String) -> void:
	control_screen.set_text_button(text)

func _on_end_turn_button_pressed() -> void:
	if player.my_turn:
		player.my_turn = false
		player.emit_signal("turn_ended")
