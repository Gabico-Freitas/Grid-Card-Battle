extends Enemy
class_name Melee

@onready var health_bar = $HealthBar
var move_points : int
var path : Array[Vector2i]
var has_attacked : bool

func _ready() -> void:
	hp = 20
	health_bar.set_up(hp)
	sprite = $AnimatedSprite2D
	sprite.animation_finished.connect(_on_animation_finished)

func new_turn_refresh() -> void:
	move_points = 2
	path = grid.path_to_player(self)
	has_attacked = false

func do_move() -> bool:
	if has_attacked: return true
	if _try_attack():
		has_attacked = true
		return false
	if move_points<=0: return true
	
	if path.is_empty(): return true
	var next_cell = path.pop_front()
	match sign(grid.get_entity_pos(self).x - next_cell.x):
		1: facing_left = true
		-1: facing_left = false
	grid.set_entity_pos(self, next_cell)
	move_points -= 1
	
	return false

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
				if(i>0): facing_left = false
				if(i<0): facing_left = true
				SFXManager.play("melee_attack", 5)
				return true
	return false

func get_attack_zone() -> Array[Vector2i]:
	var zone : Array[Vector2i]
	zone = []
	zone.append(Vector2i(0,1))
	zone.append(Vector2i(0,-1))
	zone.append(Vector2i(1,0))
	zone.append(Vector2i(-1,0))
	return zone

func _on_damaged(_value: int) -> void:
	health_bar.update_health(hp)
