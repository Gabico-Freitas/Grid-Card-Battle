extends Enemy
class_name Melee

@onready var health_bar = $HealthBar
var move_points : int

func _ready() -> void:
	hp = 20
	health_bar.set_up(hp)
	sprite = $AnimatedSprite2D
	sprite.animation_finished.connect(_on_animation_finished)

func do_turn() -> void:
	move_points = 2
	var path = grid.path_to_player(self)
	
	if _try_attack(): return
	while(move_points > 0):
		if path.is_empty(): return
		var next_cell = path.pop_front()
		grid.set_entity_pos(self, next_cell)
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
				sprite.play("attack")
				return true
	return false

func _on_damaged(_value: int) -> void:
	health_bar.update_health(hp)
