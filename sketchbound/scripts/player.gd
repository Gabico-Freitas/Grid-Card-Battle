extends Entity
class_name Player

const MAX_MOVE_POINTS := 3
var move_points := MAX_MOVE_POINTS
const MAX_MANA := 5
var mana := MAX_MANA

var draw_pile : Array[Card] = []
var hand : Array[Card] = []
var discard_pile : Array[Card] = []

var selected_card : Card = null
var aim_direction : Direction

signal turn_ended
signal moved(curr_moves: int, max_moves:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = 36
	moved.emit(move_points,MAX_MOVE_POINTS)
	#TEMPORARY!!! (TODO) (Deck provavelmente vai ficar num autoload)
	for i in range(10):
		draw_pile.append(PunchCard.new())
	draw_pile.shuffle()

func new_turn_refresh() -> void:
	move_points = MAX_MOVE_POINTS
	mana = MAX_MANA
	my_turn = true
	moved.emit(move_points,MAX_MOVE_POINTS)
	discard_pile.append_array(hand)
	hand.clear()
	
	_draw_cards()

func _draw_cards() -> void:
	for i in range(5):
		if(draw_pile.size() == 0): _discard_to_draw()
		var c = draw_pile.pop_front()
		hand.append(c)

func _discard_to_draw() -> void:
	draw_pile.append_array(discard_pile)
	discard_pile.clear()
	draw_pile.shuffle()

func _use_card(c:Card, dir:Direction) -> bool:
	if(mana < c.mana_cost): return false
	if(move_points < c.movement_cost): return false
	mana -= c.mana_cost
	move_points -= c.movement_cost
	
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
	
	return true

func _unhandled_input(event: InputEvent) -> void:
	if(!my_turn): return
	
	if(selected_card == null): _handle_input_no_selected_card(event)
	else: _handle_input_selected_card(event)

func _handle_input_no_selected_card(event: InputEvent) -> void:
	if (event.is_action_pressed("EndPlayerTurn")):
		my_turn = false
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
				moved.emit(move_points,MAX_MOVE_POINTS)
		elif (event.is_action_pressed("Down")):
			if grid.move_down(self):
				move_points -= 1
				moved.emit(move_points,MAX_MOVE_POINTS)
		elif (event.is_action_pressed("Left")):
			if grid.move_left(self):
				move_points -= 1
				moved.emit(move_points,MAX_MOVE_POINTS)
	
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
		aim_direction = Direction.UP

func _handle_input_selected_card(event: InputEvent) -> void:
	if(event.is_action_pressed("UnselectCard")): selected_card = null
	
	if(event.is_action_pressed("AimUp")): aim_direction = Direction.UP
	if(event.is_action_pressed("AimRight")): aim_direction = Direction.RIGHT
	if(event.is_action_pressed("AimDown")): aim_direction = Direction.DOWN
	if(event.is_action_pressed("AimLeft")): aim_direction = Direction.LEFT
	
	if(event.is_action_pressed("UseCard")): 
		_use_card(selected_card, aim_direction)
		selected_card = null

enum Direction {
	UP,
	RIGHT,
	DOWN,
	LEFT
}
