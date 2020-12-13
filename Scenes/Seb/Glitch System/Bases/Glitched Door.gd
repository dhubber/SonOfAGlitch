extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"

var collider : CollisionShape2D
var tileMap : TileMap

var tileCoord : Vector2
var tileId : int
var autotileId : Vector2
var flippedX : bool
var flippedY : bool

func _ready():
	._ready()
	collider = get_node("StaticBody2D/CollisionShape2D")
	collider.disabled = true
	tileMap = get_parent()
	tileCoord = tileMap.world_to_map(position)
	
func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()
	collider.disabled = false
	RemoveTile()
	RefreshPathfinding()
	
	
func OnDeactivateGlitch():
	if !glitchActive: return
	.OnDeactivateGlitch()
	collider.disabled = true
	RestoreTile()
	RefreshPathfinding()
	

func RefreshPathfinding():
	tileMap.update_dirty_quadrants()
	level.refresh_pathfinding()

func RemoveTile():
	tileId = tileMap.get_cell(tileCoord.x, tileCoord.y)
	flippedX = tileMap.is_cell_x_flipped(tileCoord.x, tileCoord.y)
	flippedY = tileMap.is_cell_y_flipped(tileCoord.x, tileCoord.y)
	autotileId = tileMap.get_cell_autotile_coord(tileCoord.x, tileCoord.y)
	tileMap.set_cell(tileCoord.x, tileCoord.y, -1)
	
func RestoreTile():
	tileMap.set_cell(tileCoord.x, tileCoord.y, tileId, flippedX, flippedY,
	false, autotileId)

func ChangeTile(newTile : int):
	var tileCoord = tileMap.world_to_map(position)
	tileMap.set_cell(tileCoord.x, tileCoord.y, newTile,
		tileMap.is_cell_x_flipped(tileCoord.x, tileCoord.y),
		tileMap.is_cell_y_flipped(tileCoord.x, tileCoord.y));
