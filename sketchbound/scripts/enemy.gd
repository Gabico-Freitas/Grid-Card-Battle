@abstract
extends Entity
class_name Enemy

var highlighted_cells := []

@abstract
func do_move() -> bool
# return whether or not the enemy has finished its turn

func _on_button_mouse_entered() -> void:
	var attack_zone = self.get_attack_zone()
	var my_pos = grid.get_entity_pos(self)
	for tile in attack_zone:
		var target_cell = my_pos + tile
		grid.highlight_cell(target_cell, true)
		highlighted_cells.append(target_cell)

func _on_button_mouse_exited() -> void:
	for cell in highlighted_cells:
		grid.highlight_cell(cell, false)
	highlighted_cells.clear()

@abstract
func get_attack_zone() -> Array[Vector2i]
