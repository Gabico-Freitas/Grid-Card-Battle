extends Card
class_name FangsCard

func _init() -> void: 
	id = 6
	mana_cost = 2
	movement_cost = 1
	damage = 5
	area_of_effect = []
	area_of_effect.append(Vector2i(1,-1))
	area_of_effect.append(Vector2i(1,-2))
	area_of_effect.append(Vector2i(-1,-1))
	area_of_effect.append(Vector2i(-1,-2))
