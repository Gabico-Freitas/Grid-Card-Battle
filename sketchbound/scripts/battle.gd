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
	
	if enemies.is_empty(): get_tree().change_scene_to_file("res://UI/win_screen.tscn")
	
	for e in enemies: e.do_turn()
	
	if player.is_dead(): get_tree().change_scene_to_file("res://UI/game_over.tscn")
	player.new_turn_refresh()
	pass

func _on_player_turn_ended() -> void:
	enemies_turn()
