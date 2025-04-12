@tool
class_name MapModifierSmoothing extends MapModifier
# Uses cellular automata to smooth the map.

@export_range(0, 32, 1) var iterations: int = 1
@export_range(0, 9, 1) var threshold: int = 5
@export var active_tile: Tile = Tile.new()
@export var inactive_tile: Tile = Tile.new()

func modify(map: ProceduralMap) -> void:
	for i in range(iterations):
		_iterate(map)

# Performs a single iteration of the algorithm.
func _iterate(map: ProceduralMap) -> void:
	# Changes are stored and applied at the end of each iteration instead of during it.
	var active_coords: Array[Vector2i] = []
	var inactive_coords: Array[Vector2i] = []
	for x in range(map.size.x):
		for y in range(map.size.y):
			var coords := Vector2i(x, y)
			# If enough active tiles are around a point, it becomes active.
			if _get_active_count(map, coords) >= threshold:
				active_coords.push_back(coords)
			# Otherwise it becomes inactive.
			else:
				inactive_coords.push_back(coords)
	for c in active_coords:
		map.set_cell_tile(c, active_tile)
	for c in inactive_coords:
		map.set_cell_tile(c, inactive_tile)

# Returns the number of active tiles in a 3x3 area (Moore neighborhood) around the given point.
func _get_active_count(map: ProceduralMap, coords: Vector2i) -> int:
	var n := 0
	for x in range(-1, 2):
		for y in range(-1, 2):
			var current := coords + Vector2i(x, y)
			n += int(active_tile.equals(map.get_cell_tile(current)))
	return n
