extends Enemy

var move_points : int

func _ready() -> void:
	hp = 28

func do_turn() -> void:
	move_points = 0
	if _try_attack(): return

# Pega a posição do player, verifica se ele está ao redor do esmagador, 
# somando com um vetor para cada posição possivel
func _try_attack() -> bool:
	var target_cell = grid.get_entity_pos(self) #+ Vector2i(0, 1)
	for i in range(-1, 2):
		for j in range(-1, 2):
			target_cell = target_cell + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				entity.take_damage(3)
				return true
	return false
