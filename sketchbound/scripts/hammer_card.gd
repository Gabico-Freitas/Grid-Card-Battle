extends Card
class_name HammerCard

func _init() -> void:
	id = 4
	mana_cost = 1
	movement_cost = 2
	damage = 7
	area_of_effect = []
	area_of_effect.append(Vector2i(0,-1))
	sound_key = "hammer"
