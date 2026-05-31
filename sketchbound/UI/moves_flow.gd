extends HFlowContainer

@export var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(player.MAX_MOVE_POINTS):
		var icon = $MovesIcon.duplicate()
		add_child(icon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_moved(curr_moves: int, max_moves: int) -> void:
	for i in range(get_child_count()):
		var icon = get_child(i)
		if i < curr_moves:
			icon.modulate.a = 1.0
		else:
			icon.modulate.a = 0.0
