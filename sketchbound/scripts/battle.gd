extends Node2D

@onready var grid := $Grid
var player : Player
var enemies : Array[Enemy]
var is_player_turn : bool

@export var manual_popup := false

@onready var ui := $UI
var tween: Tween
@export var curva: Curve

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for entity in grid.get_children():
		if(entity is Player):
			player = entity
		elif(entity is Enemy):
			enemies.append(entity)
	
	ui.set_text_button("COMEÇAR")
	if(manual_popup): await ui.control_screen.hidden
	else: ui.control_screen.hide()
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
		await leaf_animation()
		death(1)
func leaf_animation() -> void:
	var pos_inicial = player.sprite.global_position
	var tempo_queda = 4.0       
	var altura_queda = DisplayServer.window_get_size().y-pos_inicial.y
	var largura_balanco = 200.0
	tween.tween_method(
		func(progresso: float):
			var valor_curva = curva.sample(progresso)
			var deslocamento_x = valor_curva * largura_balanco
			player.sprite.global_position.x = pos_inicial.x + deslocamento_x
			player.sprite.global_position.y = pos_inicial.y + (progresso * altura_queda)
			player.sprite.rotation = valor_curva * 0.5, 0.0, 1.0, tempo_queda).set_trans(Tween.TRANS_LINEAR)

	await tween.finished
	
func _on_player_turn_ended() -> void:
	enemies_turn()
