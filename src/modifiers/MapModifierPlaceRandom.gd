@tool
class_name MapModifierPlaceRandom extends MapModifier
# Randomly places tiles on map.

@export var tile: Tile = Tile.new()
@export_range(0.0, 1000.0, 1.0, "or_greater") var deviation: float = 1.0
@export_range(0.0, 1000.0, 1.0, "or_greater") var mean: float = 10.0
@export var tile_mask: Array[Tile] = [Tile.new()]

func modify(map: ProceduralMap) -> void:
	var valid_coords: Array[Vector2i] = []
	for x in range(map.size.x):
		for y in range(map.size.y):
			var coords := Vector2i(x, y)
			var current_tile := map.get_cell_tile(coords)
			if tile_mask.any(current_tile.equals):
				valid_coords.append(coords)
	# Choose how many tiles to place.
	var count := clampi(map.rng.randfn(mean, deviation), 0, valid_coords.size())
	_shuffle(valid_coords, map.rng)
	for i in range(count):
		map.set_cell_tile(valid_coords[i], tile)

# Fisher–Yates shuffle
func _shuffle(array: Array[Vector2i], rng: RandomNumberGenerator) -> void:
	var n := array.size()
	for i in range(n - 1):
		var j := rng.randi_range(i, n - 1)
		var elem := array[i]
		array[i] = array[j]
		array[j] = elem
