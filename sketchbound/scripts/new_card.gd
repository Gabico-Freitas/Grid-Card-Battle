extends Card
class_name NewCard


#func _init() -> void: #Ataque zig zag
	#id = 8
	#mana_cost = 2
	#damage = 7
	#area_of_effect = []
	#area_of_effect.append(Vector2i(0,-1))
	#area_of_effect.append(Vector2i(1,-2))
	#area_of_effect.append(Vector2i(0,-3))
	#area_of_effect.append(Vector2i(-1,-4))
	#area_of_effect.append(Vector2i(0,-5))
	#area_of_effect.append(Vector2i(1,-6))
	#area_of_effect.append(Vector2i(0,-7))

#func _init() -> void: #Evolucao da flecha, acerta em formato de +
	#id = 6
	#mana_cost = 2
	#damage = 7
	#area_of_effect = []
	#area_of_effect.append(Vector2i(0,-3))
	#area_of_effect.append(Vector2i(0,-4))
	#area_of_effect.append(Vector2i(0,-2))
	#area_of_effect.append(Vector2i(1,-3))
	#area_of_effect.append(Vector2i(-1,-3))
	
#func _init() -> void: #Ataque na diagonal 2 blocos (2 diagonais)
	#id = 7
	#mana_cost = 2
	#damage = 7
	#area_of_effect = []
	#area_of_effect.append(Vector2i(1,-1))
	#area_of_effect.append(Vector2i(2,-2))
	#area_of_effect.append(Vector2i(-1,-1))
	#area_of_effect.append(Vector2i(-2,-2))
