@tool
class_name ProceduralMap extends TileMapLayer

@export_tool_button("Generate") var generate_action = generate
@export_tool_button("Clear") var clear_action = clear

@export var size: Vector2i = Vector2i(64, 64):
	set(value):
		size = value.maxi(0)
@export var seed: int = 0
@export var modifiers: Array[MapModifier] = []
var rng: RandomNumberGenerator

# Clears existing tiles and applies MapModifiers to generate the map.
func generate() -> void:
	clear()
	rng = RandomNumberGenerator.new()
	rng.seed = seed
	for m in modifiers:
		if m != null:
			m.modify(self)

# Returns a Tile object that represents the tile at the given coords.
func get_cell_tile(coords: Vector2i) -> Tile:
	var tile := Tile.new()
	tile.source_id = get_cell_source_id(coords)
	tile.alternative_tile = get_cell_alternative_tile(coords)
	tile.atlas_coords = get_cell_atlas_coords(coords)
	return tile

# Sets the tile at the given coords to match the given Tile object.
func set_cell_tile(coords: Vector2i, tile: Tile) -> void:
	set_cell(coords, tile.source_id, tile.atlas_coords, tile.alternative_tile)
