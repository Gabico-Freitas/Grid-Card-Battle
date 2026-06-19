extends Node2D

@onready var grid := $Grid
var player : Player
var enemies : Array[Enemy]
var is_player_turn : bool

@onready var ui := $UI
var tween: Tween

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
	
	if enemies.is_empty(): GlobalData.next_level()
	
	for e in enemies:
		e.new_turn_refresh()
		while(!e.do_move()): await get_tree().create_timer(1.0).timeout
	
	if player.is_dead():
		death(0)
		
	player.new_turn_refresh()
	pass

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

func death(mode: int) ->void:
	reset_tween()
	if mode==1:
		get_tree().change_scene_to_file("res://UI/game_over.tscn")
		GlobalData.reset_level_count()
	else:
		tween.tween_property(player.sprite, "skew", 0.5, 3.2)
		var destino = Vector2(player.sprite.offset.x, 120)
		tween.tween_property(player.sprite, "offset", destino, 5.2)
		await tween.finished
		death(1)

func _on_player_turn_ended() -> void:
	enemies_turn()
