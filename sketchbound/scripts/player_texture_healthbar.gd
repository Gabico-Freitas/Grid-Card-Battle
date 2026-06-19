extends TextureProgressBar
const MAX_HP = 36
var currHealth = MAX_HP
@onready var health = $PlayerHealth

@export var shake_amount: float = 8.0
@export var shake_duration: float = 0.2
@onready var default_position: Vector2 = position
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_value = MAX_HP
	set_health_bar()
	set_health_label()
	
func set_health_bar() ->void:
	self.value = currHealth
	
func set_health_label() ->void:
	if currHealth>0:
		health.text = str(currHealth)
	else:
		health.text = "0"

func _on_player_damaged(value: int) -> void:
	currHealth = value
	set_health_bar()
	set_health_label()
	if currHealth>0:
		shake()

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

func shake():
	reset_tween()
	var elapsed_time = 0.0
	while elapsed_time < shake_duration:
		var random_offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
		position = default_position + random_offset
		await get_tree().process_frame
		elapsed_time += get_process_delta_time()
	position = default_position
