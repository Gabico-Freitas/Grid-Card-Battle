extends Enemy

@onready var health_bar = $HealthBar
var move_points : int

func _ready() -> void:
	hp = 15
	health_bar.set_up(hp)

func do_turn() -> void:
	move_points = 1
	if _try_attack(): return
	while(move_points > 0):
		grid.move_right(self)
		move_points -= 1
		if _try_attack(): return

func _try_attack() -> bool:
	var target_cell = grid.get_entity_pos(self) + Vector2i(0, 1)
	var entity = grid.get_entity(target_cell)
	if entity is Player:
		entity.take_damage(8)
		return true
	return false

func _on_damaged(_value: int) -> void:
	health_bar.update_health(hp)
