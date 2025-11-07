extends CharacterBody3D

@export var animationTree : AnimationTree
@export var locomotionBlendPath : String
@export var transitionSpeed : float = 0.1
@export var speed : float = 5.0
@export var jumpVelocity : float = 4.5

var currentInput : Vector2
var currentVelocity : Vector2

func _process(delta: float) -> void:
	var newDelta = currentInput - currentVelocity
	if newDelta.length() > transitionSpeed * delta :
		newDelta = newDelta.normalized() * transitionSpeed * delta
	
	currentVelocity += newDelta
	
	animationTree.set(locomotionBlendPath, currentVelocity)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	currentInput = Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(currentInput.x, 0, currentInput.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
