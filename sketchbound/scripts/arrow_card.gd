extends Card
class_name ArrowCard

func _init() -> void:
	id = 2
	mana_cost = 2
	damage = 7
	area_of_effect = []
	area_of_effect.append(Vector2i(0,-3))
	sound_key = "arrow"
	sound_db = 4
