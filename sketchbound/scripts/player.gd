extends Entity
class_name Player

const MAX_MOVE_POINTS := 3
var move_points := MAX_MOVE_POINTS
const MAX_MANA := 5
var mana := MAX_MANA

var draw_pile : Array[Card] = []
var hand : Array[Card] = []
var discard_pile : Array[Card] = []
var stolen : bool

@export var ui : UI
var aiming = false

var selected_card : Card = null
var aim_direction := Direction.RIGHT
var highlighted_cells:= []

signal turn_ended
signal moved(curr_moves: int, max_moves:int)
signal mana_spent(curr_mana: int, max_mana: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = 36
	moved.emit(move_points,MAX_MOVE_POINTS)
	mana_spent.emit(mana, MAX_MANA)
	draw_pile = GlobalData.deck.duplicate()
	draw_pile.shuffle()
	sprite = $AnimatedSprite2D
	sprite.animation_finished.connect(_on_animation_finished)

func new_turn_refresh() -> void:
	move_points = MAX_MOVE_POINTS
	mana = MAX_MANA
	if stolen:
		move_points -= 1
		mana -= 1
		stolen = false
	my_turn = true
	moved.emit(move_points,MAX_MOVE_POINTS)
	mana_spent.emit(mana, MAX_MANA)
	discard_pile.append_array(hand)
	hand.clear()
	
	_draw_cards()

func _draw_cards() -> void:
	for i in range(5):
		if(draw_pile.size() == 0): _discard_to_draw()
		var c = draw_pile.pop_front()
		hand.append(c)
	ui.update_hand(hand)

func _discard_to_draw() -> void:
	draw_pile.append_array(discard_pile)
	discard_pile.clear()
	draw_pile.shuffle()

func _use_card(c:Card, dir:Direction) -> bool:
	if(mana < c.mana_cost): 
		mana_spent.emit(-1, MAX_MANA)
		SFXManager.play("no_mana", -4.5)
		return false
	if(move_points < c.movement_cost): 
		moved.emit(-1,MAX_MOVE_POINTS)
		SFXManager.play("no_move", 2)
		return false
	mana -= c.mana_cost
	move_points -= c.movement_cost
	
	moved.emit(move_points,MAX_MOVE_POINTS)
	mana_spent.emit(mana, MAX_MANA)
	
	var aof
	match dir:
		Direction.UP: aof = c.get_aof_up() 
		Direction.RIGHT: aof = c.get_aof_right()
		Direction.DOWN: aof = c.get_aof_down()
		Direction.LEFT: aof = c.get_aof_left()
	
	var my_pos = grid.get_entity_pos(self)
	for tile in aof:
		var target_entity = grid.get_entity(my_pos + tile)
		if target_entity==null or target_entity is not Enemy: continue
		target_entity.take_damage(c.damage)
	
	hand.erase(c)
	discard_pile.append(c)
	if is_instance_valid(ui):
		ui.update_hand(hand)
	
	if(dir==Direction.RIGHT):
		facing_left = false
	elif(dir==Direction.LEFT):
		facing_left = true
	sprite.play("attack")
	c.play_sfx()
	
	return true

func _unhandled_input(event: InputEvent) -> void:
	if(!my_turn): return
	
	if(selected_card == null): _handle_input_no_selected_card(event)
	else: _handle_input_selected_card(event)

func _handle_input_no_selected_card(event: InputEvent) -> void:
	if (event.is_action_pressed("EndPlayerTurn")):
		my_turn = false
		_update_highlight_card_aof()
		emit_signal("turn_ended")
		return
	
	if (move_points > 0):
		if (event.is_action_pressed("Up")):
			if grid.move_up(self):
				move_points -= 1
				moved.emit(move_points,MAX_MOVE_POINTS)
		elif (event.is_action_pressed("Right")):
			if grid.move_right(self):
				move_points -= 1
				facing_left = false
				moved.emit(move_points,MAX_MOVE_POINTS)
		elif (event.is_action_pressed("Down")):
			if grid.move_down(self):
				move_points -= 1
				moved.emit(move_points,MAX_MOVE_POINTS)
		elif (event.is_action_pressed("Left")):
			if grid.move_left(self):
				move_points -= 1
				facing_left = true
				moved.emit(move_points,MAX_MOVE_POINTS)
	else:
		if event is InputEventKey and event.is_pressed() and not event.is_echo() and not event.is_action_pressed("UseCard"):
			moved.emit(-1,MAX_MOVE_POINTS)
			SFXManager.play("no_move", 2)
	
	var selected_card_number = -1
	if(event.is_action_pressed("SelectCard1")): selected_card_number = 1
	if(event.is_action_pressed("SelectCard2")): selected_card_number = 2
	if(event.is_action_pressed("SelectCard3")): selected_card_number = 3
	if(event.is_action_pressed("SelectCard4")): selected_card_number = 4
	if(event.is_action_pressed("SelectCard5")): selected_card_number = 5
	var card
	if(selected_card_number > 0 and selected_card_number <= hand.size()): card = hand.get(selected_card_number - 1)
	if card != null: 
		selected_card = card
		_update_highlight_card_aof()

func _handle_input_selected_card(event: InputEvent) -> void:
	if(event.is_action_pressed("UnselectCard")): 
		selected_card = null
		_update_highlight_card_aof()
	
	if(event.is_action_pressed("Up")): 
		aim_direction = Direction.UP
		_update_highlight_card_aof()
	if(event.is_action_pressed("Right")):
		aim_direction = Direction.RIGHT
		_update_highlight_card_aof()
	if(event.is_action_pressed("Down")):
		aim_direction = Direction.DOWN
		_update_highlight_card_aof()
	if(event.is_action_pressed("Left")):
		aim_direction = Direction.LEFT
		_update_highlight_card_aof()
	
	if(event.is_action_pressed("UseCard")): 
		_use_card(selected_card, aim_direction)
		selected_card = null
		_update_highlight_card_aof()

func _update_highlight_card_aof() -> void:
	for cell in highlighted_cells:
		grid.highlight_cell_red(cell, false)
	highlighted_cells.clear()
	if selected_card == null: return
	
	var aof
	match aim_direction:
		Direction.UP: aof = selected_card.get_aof_up() 
		Direction.RIGHT: aof = selected_card.get_aof_right()
		Direction.DOWN: aof = selected_card.get_aof_down()
		Direction.LEFT: aof = selected_card.get_aof_left()
	
	var my_pos = grid.get_entity_pos(self)
	for tile in aof:
		var target_cell = my_pos + tile
		grid.highlight_cell_red(target_cell, true)
		highlighted_cells.append(target_cell)

enum Direction {
	UP,
	RIGHT,
	DOWN,
	LEFT
}
