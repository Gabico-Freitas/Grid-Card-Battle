extends ProgressBar
var currHealth
@onready var health = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setUp(max_hp) ->void:
	self.max_value = max_hp
	currHealth = max_hp
	set_health_bar()
	set_health_label()

func set_health_bar() ->void:
	self.value = currHealth
	
func set_health_label() ->void:
	health.text = str(currHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_melee_damaged(value:int) -> void:
	currHealth = value
	set_health_bar()
	set_health_label()
