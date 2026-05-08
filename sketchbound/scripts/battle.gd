extends Node2D

@onready var grid := $Grid
var player : Player
var enemies : Array[Enemy]
var is_player_turn : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for entity in grid.get_children():
		if(entity is Player):
			player = entity
		elif(entity is Enemy):
			enemies.append(entity)
	
	player.my_turn = true

func enemies_turn() -> void:
	for e in enemies:
		e.do_turn()
	
	if player.is_dead(): get_tree().quit()
	player.new_turn_refresh()
	pass

func _on_player_turn_ended() -> void:
	enemies_turn()
