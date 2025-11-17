extends Node3D

var bullet : PackedScene = load("res://scenes/bullet.tscn")
var instance : Node3D
@onready var shoot_timer: Timer = $ShootTimer


func _on_shoot_timer_timeout() -> void:
	instance = bullet.instantiate()
	instance.position = global_position
	instance.transform.basis = global_transform.basis
	get_tree().current_scene.add_child(instance)
	shoot_timer.start()
