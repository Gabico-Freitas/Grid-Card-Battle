extends VSlider
@export var music_icon: TextureRect
var bus_index: int
const music = preload("res://UI/Icons/music_symbol.png")
const no_music = preload("res://UI/Icons/no_music_symbol.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index("musica")
	music_icon.texture = music


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
	if self.value==0:
		music_icon.texture = no_music
	else:
		music_icon.texture = music
