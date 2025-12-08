extends Node3D

var bullet : PackedScene = load("res://scenes/bullet.tscn")
var instance : Node3D

@export var aim_ray : RayCast3D

func _process(_delta):
	var target_pos : Vector3

	if aim_ray.is_colliding():
		target_pos = aim_ray.get_collision_point()
	else:
		target_pos = aim_ray.to_global(Vector3(0,0,-100))

	look_at(target_pos, Vector3.UP)

func shoot():
	instance = bullet.instantiate()
	instance.position = $RayCast3D.global_position
	instance.transform.basis = global_transform.basis
	get_tree().current_scene.add_child(instance)
