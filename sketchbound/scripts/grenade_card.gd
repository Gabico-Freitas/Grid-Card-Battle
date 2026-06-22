extends Card
class_name GrenadeCard

func _init() -> void:
	id = 7
	mana_cost = 3
	damage = 10
	area_of_effect = []
	area_of_effect.append(Vector2i(0,-3))
	area_of_effect.append(Vector2i(0,-4))
	area_of_effect.append(Vector2i(0,-2))
	area_of_effect.append(Vector2i(1,-3))
	area_of_effect.append(Vector2i(-1,-3))
