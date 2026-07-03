extends TextureRect
const fangs_card = preload("res://UI/cards_images/fangs_image.png")
const grenade_card = preload("res://UI/cards_images/grenade_image.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GlobalData.current_level:
		2:
			self.texture = fangs_card
		3: 
			self.texture = grenade_card

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
