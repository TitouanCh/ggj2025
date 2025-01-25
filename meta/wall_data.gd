class_name WallData
extends ObjectData

@export var to_position: Vector2 = Vector2(32, 0)

static var scenes = {
	"Normal": load("res://game/mur.tscn"),
	"Hublot": load("res://game/hublot.tscn"),
	"Door": load("res://game/mur_porte.tscn"),
	"Gris": load("res://game/mur_gris.tscn"),
	"Vert": load("res://game/mur_vert")
}
