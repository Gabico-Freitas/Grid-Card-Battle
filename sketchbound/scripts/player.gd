extends Entity
class_name Player

const MAX_MOVE_POINTS := 3
var move_points := MAX_MOVE_POINTS

signal turn_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = 36

func new_turn_refresh() -> void:
	move_points = MAX_MOVE_POINTS
	my_turn = true

func _unhandled_input(event: InputEvent) -> void:
	if(!my_turn): return
	
	if (event.is_action_pressed("EndPlayerTurn")):
		my_turn = false
		emit_signal("turn_ended")
		return
	
	if (move_points > 0):
		if (event.is_action_pressed("Up")):
			if grid.move_up(self):
				move_points -= 1
		elif (event.is_action_pressed("Right")):
			if grid.move_right(self):
				move_points -= 1
		elif (event.is_action_pressed("Down")):
			if grid.move_down(self):
				move_points -= 1
		elif (event.is_action_pressed("Left")):
			if grid.move_left(self):
				move_points -= 1
