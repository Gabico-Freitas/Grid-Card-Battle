extends ProgressBar
const MAX_HP = 36
var currHealth = MAX_HP
@onready var health = $PlayerHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_value = MAX_HP
	set_health_bar()
	set_health_label()
	
func set_health_bar() ->void:
	self.value = currHealth
	
func set_health_label() ->void:
	health.text = str(currHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_damaged(value: int) -> void:
	currHealth = value
	set_health_bar()
	set_health_label()
