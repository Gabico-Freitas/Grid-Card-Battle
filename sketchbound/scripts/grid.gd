extends TileMapLayer
class_name Grid

var cell_content : Dictionary[Vector2i, Entity]
var astar : AStarGrid2D

@export var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if(child is Entity):
			cell_content[child.initial_pos] = child
	
	astar = AStarGrid2D.new()
	astar.region = get_used_rect()
	astar.cell_size = Vector2i(108,108)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

func get_entity(pos:Vector2i) -> Entity:
	if cell_content.has(pos):
		return cell_content[pos]
	else:
		return null

func get_entity_pos(e:Entity) -> Vector2i:
	return cell_content.find_key(e)

func get_entity_world_coordinates(e:Entity) -> Vector2:
	var pos = get_entity_pos(e)
	return map_to_local(pos)

func set_entity_pos(e:Entity, new_pos:Vector2i) -> void:
	if(cell_content.has(new_pos)): return
	cell_content.erase(get_entity_pos(e))
	cell_content[new_pos] = e

func move_up(e:Entity) -> bool:
	var cell = get_entity_pos(e)
	var up_cell = get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_TOP_SIDE)
	if(_cell_exists(up_cell) and !cell_content.has(up_cell)):
		set_entity_pos(e, up_cell)
		return true
	else:
		return false

func move_right(e:Entity) -> bool:
	var cell = get_entity_pos(e)
	var right_cell = get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_RIGHT_SIDE)
	if(_cell_exists(right_cell) and !cell_content.has(right_cell)):
		set_entity_pos(e, right_cell)
		return true
	else:
		return false

func move_down(e:Entity) -> bool:
	var cell = get_entity_pos(e)
	var down_cell = get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
	if(_cell_exists(down_cell) and !cell_content.has(down_cell)):
		set_entity_pos(e, down_cell)
		return true
	else:
		return false

func move_left(e:Entity) -> bool:
	var cell = get_entity_pos(e)
	var left_cell = get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_LEFT_SIDE)
	if(_cell_exists(left_cell) and !cell_content.has(left_cell)):
		set_entity_pos(e, left_cell)
		return true
	else:
		return false

func path_to_player(e:Enemy) -> Array[Vector2i]:
		astar.fill_solid_region(get_used_rect(), false)
		for occupied_cell in cell_content.keys():
			astar.set_point_solid(occupied_cell, true)
		astar.set_point_solid(get_entity_pos(e), false)
		astar.set_point_solid(get_entity_pos(player), false)
		
		var path = astar.get_id_path(get_entity_pos(e), get_entity_pos(player))
		path.pop_front()
		path.pop_back()
		return path

func _cell_exists(cell:Vector2i) -> bool:
	return get_cell_source_id(cell) != -1
