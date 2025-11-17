extends Node3D

var bullet : PackedScene = load("res://scenes/bullet.tscn")
var instance : Node3D

func shoot():
	print("tire")
	print($RayCast3D.position,  global_transform.basis)
	instance = bullet.instantiate()
	instance.position = $RayCast3D.position
	instance.transform.basis = global_transform.basis
	get_tree().current_scene.add_child(instance)
