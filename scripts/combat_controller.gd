extends Node

@export var HandContainer : Node3D
@export var HipContainer: Node3D
@export var ItemContainer : Node3D
@export var upperBodyStatePlaybackPath : String
@export var pointingStance : String = "CharacterArmature|Idle_Gun_Pointing"

@export var animationTree : AnimationTree

var isInCombat : bool = false

func _ready() -> void:
	var parent = ItemContainer.get_parent()
	parent.remove_child(ItemContainer)
	HandContainer.add_child(ItemContainer)
	ItemContainer.position = Vector3.ZERO
	ItemContainer.rotation_degrees = Vector3.ZERO
