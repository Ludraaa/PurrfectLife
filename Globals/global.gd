extends Node

@export var game : Node2D
@export var tileMap : Node2D
@export var floorLayer : TileMapLayer
@export var layer1 : TileMapLayer
@export var floorTile = preload("res://scenes/floor.tscn")

@export var mousePos : Vector2
@export var mousePos0 : Vector2i

@export var gameTime : float

@export var deleteCursor : Resource = preload("res://assets/curser_pack/destroy.png")
@export var placeCursor : Resource = preload("res://assets/curser_pack/build.png")
@export var defaultCursor : Resource = preload("res://assets/curser_pack/curser.png")
@export var paintCursor : Resource = preload("res://assets/curser_pack/paint.png")
@export var blockCursor : Resource = preload("res://assets/curser_pack/block.png")
@export var deletionCursor : Resource = preload("res://assets/curser_pack/deletion.png")
@export var zoomOutCursor : Resource = preload("res://assets/curser_pack/zoom_out.png")
@export var zoomInCursor : Resource = preload("res://assets/curser_pack/zoom_in.png")

@export var buildModeIcon : Resource = preload("res://assets/curser_pack/build_mode.png")
@export var closeIcon : Resource = preload("res://assets/curser_pack/close.png")

@export var itemSlot : Resource = preload("res://scenes/item_slot.tscn")

@export var buildShop : Panel
@export var currBuildShopTab : Enums.BUILDMODETAB
