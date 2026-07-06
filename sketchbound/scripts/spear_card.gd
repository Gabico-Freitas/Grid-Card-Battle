extends Card
class_name SpearCard

func _init() -> void:
	id = 1
	mana_cost = 2
	damage = 4
	area_of_effect = []
	area_of_effect.append(Vector2i(0,-1))
	area_of_effect.append(Vector2i(0,-2))
	area_of_effect.append(Vector2i(0,-3))
	sound_key = "spear"
	sound_db = -3.5
