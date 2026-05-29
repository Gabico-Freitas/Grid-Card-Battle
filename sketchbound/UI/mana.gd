extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_mana_spent(curr_mana: int, max_mana: int) -> void:
	self.text = "   "+str(curr_mana) +" / "+ str(max_mana)
