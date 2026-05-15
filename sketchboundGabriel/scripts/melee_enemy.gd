extends Enemy
class_name Melee

var move_points : int

func _ready() -> void:
	hp = 20
	$HealthBar.set_up(hp)

func do_turn() -> void:
	move_points = 2
	if _try_attack(): return
	while(move_points > 0):
		grid.move_right(self)
		move_points -= 1
		if _try_attack(): return

func _try_attack() -> bool:
	for i in range(-1, 2):
		for j in range(-1, 2):
			if i !=0 and j != 0:
				continue
			var target_cell = grid.get_entity_pos(self) + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				entity.take_damage(5)
				return true
	return false


func _on_damaged(value: int) -> void:
	$HealthBar.on_damaged(value)
