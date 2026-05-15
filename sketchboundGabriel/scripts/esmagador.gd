extends Enemy
class_name Smasher

var move_points : int

func _ready() -> void:
	hp = 28
	$HealthBar.set_up(hp)

func do_turn() -> void:
	move_points = 0
	if _try_attack(): return

# Pega a posição do player, verifica se ele está ao redor do esmagador, 
# somando com um vetor para cada posição possivel
func _try_attack() -> bool:
	for i in range(-1, 2):
		for j in range(-1, 2):
			var target_cell = grid.get_entity_pos(self) + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				entity.take_damage(3)
				return true
	return false


func _on_damaged(value: int) -> void:
	$HealthBar.on_damaged(value)
