extends CharacterBody3D

@export var cameraContainer: Node3D

@export var locomotionBlendPath: String
@export var upperBodyStateMachinePlaybackPath : String
var upperBodyStateMachinePlayback : AnimationNodeStateMachinePlayback

@export var shootAnimationName : String
@export var animationTree: AnimationTree
@export var transitionSpeed: float = 0.1
@export var speed: float = 5.0
@export var rotationSpeed: float = 10

var allowVelocityRotation: bool = true
var jump_velocity = 4.5

var currentInput: Vector2
var currentVelocity: Vector2

func _ready() -> void:
	upperBodyStateMachinePlayback = animationTree.get(upperBodyStateMachinePlaybackPath) as AnimationNodeStateMachinePlayback

func _process(delta):
	var newDelta = currentInput - currentVelocity
	if (newDelta.length() > transitionSpeed * delta):
		newDelta = newDelta * transitionSpeed * delta
	
	currentVelocity += newDelta
	
	animationTree.set(locomotionBlendPath, currentVelocity)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot_left")):
		upperBodyStateMachinePlayback.travel(shootAnimationName)

func _physics_process(delta):
	if !is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = 4.5
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	currentInput = Input.get_vector("left", "right", "up", "down")
	var direction = (cameraContainer.transform.basis * Vector3(currentInput.x, 0, currentInput.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		var currentNormalizedVelocity = to_local(global_position + velocity)
		currentInput = Vector2(currentNormalizedVelocity.x, currentNormalizedVelocity.z).limit_length(1)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		currentInput = Vector2.ZERO
	
	if (allowVelocityRotation):
		if (velocity.length() > 0.1):
			rotation_degrees.y = rad_to_deg(lerp_angle(deg_to_rad(rotation_degrees.y), atan2(-velocity.x, -velocity.z), delta * rotationSpeed))
	else:
		rotation_degrees.y = cameraContainer.rotation_degrees.y
	
	move_and_slide()

func DisableVelocityRotation():
	allowVelocityRotation = false

func EnableVelocityRotation():
	allowVelocityRotation = true
