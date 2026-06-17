extends Enemy

@onready var health_bar = $HealthBar
var move_points : int
var path : Array[Vector2i]
var has_attacked : bool
var has_attack_stepped : bool

func _ready() -> void:
	hp = 15
	health_bar.set_up(hp)
	sprite = $AnimatedSprite2D
	sprite.animation_finished.connect(_on_animation_finished)

func new_turn_refresh() -> void:
	move_points = 1
	path = grid.path_to_player(self)
	has_attacked = false
	has_attack_stepped = false

func do_move() -> bool:
	if has_attacked:
		if(!has_attack_stepped and _try_attack_step()):
			has_attack_stepped = true
			return false
		return true
	if _try_attack():
		has_attacked = true
		return false
	if move_points<=0: return true
	
	if path.is_empty(): return true
	var next_cell = path.pop_front()
	grid.set_entity_pos(self, next_cell)
	move_points -= 1
	
	return false

func _try_attack() -> bool:
	for i in range(-3, 4):
		for j in range(-3, 4):
			if i !=0 and j != 0:
				continue
			var target_cell = grid.get_entity_pos(self) + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				entity.take_damage(5)
				sprite.play("attack")
				return true
	return false
	
func _try_attack_step() -> bool:
	for i in range(-2, 3):
		for j in range(-2, 3):
			if i !=0 and j != 0:
				continue
			var target_cell = grid.get_entity_pos(self) + Vector2i(i, j)
			var entity = grid.get_entity(target_cell)
			if entity is Player:
				if(i ==0 && j > 0):
					grid.set_entity_pos(self, grid.get_entity_pos(self) + Vector2i(0, -1))
				elif(i ==0 && j < 0):
					grid.set_entity_pos(self, grid.get_entity_pos(self) + Vector2i(0, 1))
				elif(i <0 && j ==0 ):
					grid.set_entity_pos(self, grid.get_entity_pos(self) + Vector2i(1, 0))
				elif(i >0 && j == 0):
					grid.set_entity_pos(self, grid.get_entity_pos(self) + Vector2i(-1, 0))
				return true
	return false

func _on_damaged(_value: int) -> void:
	health_bar.update_health(hp)
