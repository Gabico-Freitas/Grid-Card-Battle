extends Card
class_name SlashCard

func _init() -> void:
	id = 3
	mana_cost = 3
	damage = 6
	area_of_effect = []
	area_of_effect.append(Vector2i(-1,-1))
	area_of_effect.append(Vector2i(0,-1))
	area_of_effect.append(Vector2i(1,-1))
	sound_key = "slash"
	sound_db = -2
