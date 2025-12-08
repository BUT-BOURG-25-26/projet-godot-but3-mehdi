extends RigidBody3D

@export var maximum_velocity : float = 18.0
@export var velocity_change : float = 18.0
@export var player_target : Node3D
@export var navigation_agent : NavigationAgent3D

var last_player_position : Vector3
var last_enemy_position : Vector3

func _physics_process(delta: float) -> void:
	if last_player_position.distance_to(player_target.global_position) > 0.5 or last_enemy_position.distance_to(global_position) > 0.5 :
		last_player_position = player_target.global_position
		last_enemy_position = global_position
		navigation_agent.target_position = last_player_position
	
	if navigation_agent.is_target_reached():
		constant_force = Vector3.ZERO
		return
	
	var target_velocity = (navigation_agent.get_next_path_position() - global_position).normalized() * maximum_velocity
	target_velocity = (target_velocity - linear_velocity) * velocity_change * delta
	
	constant_force = target_velocity
	
	if position.y < -200:
		queue_free()
