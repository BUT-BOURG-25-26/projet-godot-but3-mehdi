extends Node

signal OnCombatBegin
signal OnCombatEnd

@export var HandContainer : Node3D
@export var HipContainer: Node3D
@export var ItemContainer : Node3D
@export var upperBodyStatePlaybackPath : String
@export var pointingStance : String = "CharacterArmature|Idle_Gun_Pointing"

@export var animationTree : AnimationTree

var isInCombat : bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("drawWeapon"):
		var playblack = animationTree.get(upperBodyStatePlaybackPath) as AnimationNodeStateMachinePlayback
		if !isInCombat :
			isInCombat = true
			OnCombatBegin.emit()
			playblack.travel(pointingStance)
		else :
			isInCombat = false
			OnCombatEnd.emit()
			playblack.travel("CharacterArmature|Idle")

func Equipement():
	var parent = ItemContainer.get_parent()
	parent.remove_child(ItemContainer)
	HandContainer.add_child(ItemContainer)
	ItemContainer.position = Vector3.ZERO
	ItemContainer.rotation_degrees = Vector3.ZERO

func UnEquipement():
	var parent = ItemContainer.get_parent()
	parent.remove_child(ItemContainer)
	HipContainer.add_child(ItemContainer)
	ItemContainer.position = Vector3.ZERO
	ItemContainer.rotation_degrees = Vector3.ZERO
