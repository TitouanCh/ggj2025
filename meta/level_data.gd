class_name LevelData
extends Resource

@export var wall: Array[WallData] = []
@export var fr: Array[FRData] = []
@export var meta: Array[MetaData] = []

func to_3d_position(vec: Vector2):
	var vec3 = Vector3(vec.x, 0, vec.y) / 4.0
	return vec3

func spawn(main: Main):
	for w in wall:
		var instance = WallData.scenes[w.type].instantiate()
		instance.rotate_y((w.to_position - w.position).angle())
		main.add_child(instance)
		instance.position = (to_3d_position(w.position) + to_3d_position(w.to_position))/2.0
	for f in fr:
		var instance = FRData.scenes[f.type].instantiate()
		main.add_child(instance)
		instance.position = to_3d_position(f.position)
	for m in meta:
		var instance = MetaData.scenes[m.type].instantiate()
		instance.rotate_y(-m.rotation)
		main.add_child(instance)
		instance.position = to_3d_position(m.position)
