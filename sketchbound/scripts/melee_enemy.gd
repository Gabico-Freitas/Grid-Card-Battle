extends Enemy
class_name Melee

var move_points : int

func _ready() -> void:
	hp = 20
	$HealthBar.setUp(hp)

func do_turn() -> void:
	move_points = 2
	if _try_attack(): return
	while(move_points > 0):
		grid.move_right(self)
		move_points -= 1
		if _try_attack(): return

func _try_attack() -> bool:
	var target_cell = grid.get_entity_pos(self) + Vector2i(0, 1)
	var entity = grid.get_entity(target_cell)
	if entity is Player:
		entity.take_damage(5)
		return true
	return false
