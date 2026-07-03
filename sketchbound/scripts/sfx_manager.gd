extends Node

const NUMBER_OF_PLAYERS = 8
const SOUNDS = {
	"melee_attack": preload("res://assets/efeitos_sonoros/soco_lutador_1.wav"),
	"ranged_attack": preload("res://assets/efeitos_sonoros/tiro_sniper.wav"),
	"smasher_attack": preload("res://assets/efeitos_sonoros/britadeira_construtor_1.wav"),
	"thief_attack": preload("res://assets/efeitos_sonoros/moeda_ladrao_1.mp3"),
	"no_mana":preload("res://assets/efeitos_sonoros/sem_mana.mp3"),
	"no_move":preload("res://assets/efeitos_sonoros/no_mov_3.wav")
}
var audio_players := []

func _ready() -> void:
	for i in range(NUMBER_OF_PLAYERS):
		var p = AudioStreamPlayer.new()
		add_child(p)
		audio_players.append(p)

# Searches for available player to play sfx, if all are occupied, override one of them
func play(sound_name: String, volume_db := 0.0, pitch_variation := 0.0) -> void:
	if(!SOUNDS.has(sound_name)): return
	var sound = SOUNDS[sound_name]
	var pitch = 1.0 + randf_range(-pitch_variation, pitch_variation)
	
	for p in audio_players:
		if !p.playing:
			p.stream = sound
			p.volume_db = volume_db
			p.pitch_scale = pitch
			p.play()
			return
	var p = audio_players[0]
	p.stream = sound
	p.volume_db = volume_db
	p.pitch_scale = pitch
	p.play()

# Play sound at a specific 2d location
func play_at_position(sound_name: String, pos: Vector2, volume_db := 0.0, attenuation := 1.0, max_distance := 2000.0, loop := false) -> void:
	if !SOUNDS.has(sound_name): return
	var sound = SOUNDS[sound_name]

	var p := AudioStreamPlayer2D.new()
	p.stream = sound
	p.position = pos
	p.volume_db = volume_db
	p.attenuation = attenuation
	p.max_distance = max_distance
	add_child(p)

	if loop:
		p.finished.connect(func(): p.play())
	else:
		p.finished.connect(p.queue_free)

	p.play()
