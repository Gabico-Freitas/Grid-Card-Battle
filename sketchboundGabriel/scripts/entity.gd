extends Node2D
class_name Entity

var my_turn := false
var hp
@export var initial_pos : Vector2i
@export var grid : Grid

signal damaged(value:int)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = grid.get_entity_world_coordinates(self)
	

func take_damage(dmg:int) -> void:
	hp -= dmg
	if hp<0:
		hp=0
	damaged.emit(hp)

func is_dead() -> bool:
	return hp<=0
