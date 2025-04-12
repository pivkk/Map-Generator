@tool
class_name Tile extends Resource

@export var source_id: int = -1
@export var atlas_coords: Vector2i = Vector2i(-1, -1)
@export var alternative_tile: int = -1

func equals(x: Tile) -> bool:
	return (source_id == x.source_id) && (atlas_coords == x.atlas_coords) && (alternative_tile == x.alternative_tile)
