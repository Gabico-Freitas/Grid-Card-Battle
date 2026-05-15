extends Entity
class_name Player

const MAX_MOVE_POINTS := 3
var move_points := MAX_MOVE_POINTS
@export var health_bar : HealthBar

signal turn_ended
signal moved(curr_moves: int, max_moves:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = 36
	health_bar.set_up(hp)
	moved.emit(move_points,MAX_MOVE_POINTS)

func new_turn_refresh() -> void:
	move_points = MAX_MOVE_POINTS
	my_turn = true
	moved.emit(move_points,MAX_MOVE_POINTS)

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


func _on_damaged(value: int) -> void:
	health_bar.on_damaged(value)
