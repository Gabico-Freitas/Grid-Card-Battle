extends Node
class_name Card

var mana_cost : int
var movement_cost := 0
var damage : int
var id : int
var player_damage : int

# List of cells in the card effect's range
# (0,0) is the player's position
# Assume that the attack is being aimed upwards
var area_of_effect : Array[Vector2i]

func get_aof_up() -> Array[Vector2i]:
	var result:Array[Vector2i] = []
	for i:Vector2i in area_of_effect:
		result.append(i)
	
	return result

func get_aof_right() -> Array[Vector2i]:
	var result:Array[Vector2i] = []
	for i:Vector2i in area_of_effect:
		result.append(Vector2i(-i.y, i.x))
	
	return result

func get_aof_down() -> Array[Vector2i]:
	var result:Array[Vector2i] = []
	for i:Vector2i in area_of_effect:
		result.append(Vector2i(-i.x, -i.y))
	
	return result

func get_aof_left() -> Array[Vector2i]:
	var result:Array[Vector2i] = []
	for i:Vector2i in area_of_effect:
		result.append(Vector2i(i.y, -i.x))
	
	return result
