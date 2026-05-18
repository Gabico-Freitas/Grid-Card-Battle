extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_moved(curr_moves: int, max_moves: int) -> void:
	self.text = "Movimento: " + str(curr_moves) +" / "+ str(max_moves)
