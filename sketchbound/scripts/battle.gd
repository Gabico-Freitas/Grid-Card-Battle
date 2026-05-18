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
	
	player.new_turn_refresh()

func enemies_turn() -> void:
	var living_enemies:Array[Enemy] = []
	for e in enemies:
		if e.is_dead(): e.queue_free()
		else: living_enemies.append(e)
	enemies = living_enemies
	
	for e in enemies: e.do_turn()
	
	if player.is_dead(): get_tree().quit()
	player.new_turn_refresh()
	pass

func _on_player_turn_ended() -> void:
	enemies_turn()
