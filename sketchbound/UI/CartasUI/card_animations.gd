extends Node
class_name CardEffects

@export var ease_type: Tween.EaseType
@export var trasition_type: Tween.TransitionType
@export var animation_time: float = 0.05
@export var scale: Vector2 = Vector2(1.1,1.1)

@onready var button: Button = get_parent()
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_hovered.bind(true))
	button.mouse_exited.connect(_on_mouse_hovered.bind(false))
	button.pivot_offset_ratio = Vector2(0.5,0.5)

func _on_mouse_hovered(hovered: bool) -> void:
	reset_tween()
	tween.tween_property(button, "scale", scale if hovered else Vector2.ONE, animation_time)

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trasition_type).set_parallel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
