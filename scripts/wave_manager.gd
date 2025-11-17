extends Node3D

var instance : RigidBody3D
var monster : PackedScene
@export var player_target : Node3D

func _on_timer_timeout() -> void:
	monster = load("res://scenes/spider.tscn")
	instance = monster.instantiate()
	instance.player_target = player_target
	instance.position = Vector3(randi_range(0, 60), 0, randi_range(0, 60))
	get_tree().current_scene.add_child(instance)
