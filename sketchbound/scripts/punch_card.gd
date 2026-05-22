extends Card
class_name PunchCard

func _init() -> void:
	id = 0
	mana_cost = 1
	damage = 3
	area_of_effect = []
	area_of_effect.append(Vector2i(0,-1))
