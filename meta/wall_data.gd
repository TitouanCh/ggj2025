class_name WallData
extends ObjectData

@export var to_position: Vector2 = Vector2(32, 0)

static var scenes = {
	"Normal": load("res://game/mur.tscn"),
	"NormalInterieur": load("res://game/mur_interieur.tscn"),
	"Hublot": load("res://game/hublot.tscn"),
	"Door": load("res://game/mur_porte.tscn"),
	"Gris": load("res://game/mur_gris.tscn"),
	"Vert": load("res://game/mur_vert.tscn"),
	"DoorFermee": load("res://game/mur_porte_fermee.tscn"),
	"HublotGris": load("res://game/hublot_gris.tscn"),
	"DoorGris": load("res://game/mur_porte_grise.tscn"),
	"DoorFermeeGris": load("res://game/mur_porte_grise_fermee.tscn"),
	"HublotVert": load("res://game/hublot_vert.tscn"),
	"DoorVert": load("res://game/mur_porte_verte.tscn"),
	"DoorFermeeVert": load("res://game/mur_porte_verte_fermee.tscn"),
	"DoorBleuVert": load("res://game/porte_verte_bleu.tscn")
}
