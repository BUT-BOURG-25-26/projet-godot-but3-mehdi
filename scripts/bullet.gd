extends Node3D

@export var mesh : MeshInstance3D
@export var ray : RayCast3D

const speed := 40.0

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -speed) * delta

func _on_lifespan_timeout() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	if ray.is_colliding():
		var impact = ray.get_collider()
		var location : Vector3 = ray.get_collision_point()
		if impact is RigidBody3D:
			impact.apply_impulse(-ray.global_transform.basis.z * 20, location - impact.global_position)
			if impact.has_node("Damageable"):
				var damageable = impact.get_node("Damageable") as DamageableObject
				damageable.HurtObject(location)
