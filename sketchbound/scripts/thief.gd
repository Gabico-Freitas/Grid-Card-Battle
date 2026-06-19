extends Enemy


@onready var health_bar = $HealthBar
var move_points : int
var has_attacked : bool
var path : Array[Vector2i]

func _ready() -> void:
	hp = 15
	health_bar.set_up(hp)
	sprite = $AnimatedSprite2D
	sprite.animation_finished.connect(_on_animation_finished)

func do_move() -> bool:
	if has_attacked: return true
	if _try_attack():
		has_attacked = true
		return false
	if move_points<=0: return true
	
	if path.is_empty(): return true
	var next_cell = path.pop_front()
	grid.set_entity_pos(self, next_cell)
	move_points -= 1
	
	return false
	
func new_turn_refresh() -> void:
	move_points = 1
	path = grid.path_to_player(self)
	has_attacked = false
	
func _try_attack() -> bool:
	for i in range(-2, 3):
		for j in range(-2, 3):
			if i !=0 and j != 0:
				continue
			var target_cell = grid.get_entity_pos(self) + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				entity.take_damage(3)
				entity.stolen = true
				sprite.play("attack")
				return true
	return false

func _on_damaged(_value: int) -> void:
	health_bar.update_health(hp)


func _on_button_mouse_entered() -> void:
	print("Entrou")


func _on_button_mouse_exited() -> void:
	print("Saiu")
