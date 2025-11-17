extends Node3D

@export var mesh : MeshInstance3D
@export var ray : RayCast3D

const speed := 40.0

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -speed) * delta
