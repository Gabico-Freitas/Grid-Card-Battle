extends HFlowContainer

@export var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(player.MAX_MOVE_POINTS-1):
		var icon = $MovesIcon.duplicate()
		add_child(icon)
	
	for child in get_children():
		child.pivot_offset = child.size / 2.0

func _on_player_moved(curr_moves: int, max_moves: int) -> void:
	if curr_moves<0:
		shake()
	else:
		for i in range(get_child_count()):
			var icon = get_child(i)
			if i < curr_moves:
				icon.modulate.a = 1.0
			else:
				icon.modulate.a = 0.4

func shake() -> void:
	for child in get_children():
		if child.has_meta("shake_tween"):
			var old_tween: Tween = child.get_meta("shake_tween")
			if is_instance_valid(old_tween):
				old_tween.kill()

		var child_tween := create_tween()
		child.set_meta("shake_tween", child_tween)

		child_tween.tween_property(child, "rotation_degrees", 12.0, 0.04)
		child_tween.tween_property(child, "rotation_degrees", -12.0, 0.08)
		child_tween.tween_property(child, "rotation_degrees", 8.0, 0.04)
		child_tween.tween_property(child, "rotation_degrees", 0.0, 0.04)
