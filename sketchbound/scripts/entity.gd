@abstract
extends Node2D
class_name Entity

var my_turn := false
var hp
@export var initial_pos : Vector2i
@export var grid : Grid

@onready var sprite : AnimatedSprite2D

signal damaged(value:int)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = grid.get_entity_world_coordinates(self)

func take_damage(dmg:int) -> void:
	hp -= dmg
	sprite.play("hurt")
	if is_dead() and self is Enemy:  
		grid.erase_entity(self)
		self.hide()
		process_mode = Node.PROCESS_MODE_DISABLED
	damaged.emit(hp)
	

func is_dead() -> bool:
	return hp<=0

func _on_animation_finished() -> void:
	sprite.play("idle")
