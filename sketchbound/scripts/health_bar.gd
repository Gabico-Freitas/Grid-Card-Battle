extends ProgressBar
class_name HealthBar
var currHealth
@onready var health = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_up(max_hp) ->void:
	self.max_value = max_hp
	currHealth = max_hp
	set_health_bar()
	set_health_label()

func set_health_bar() ->void:
	self.value = currHealth
	
func set_health_label() ->void:
	health.text = str(currHealth)

func update_health(value:int) -> void:
	currHealth = value
	set_health_bar()
	set_health_label()
