extends Node2D

onready var leftBound = $"%LeftBound"
onready var rightBound = $"%RightBound"
onready var fletnicka = $"%MicrophoneInput"

export var MOVEMENT_SPEED = 100

func _physics_process(_delta):
	var extents = rightBound.position.x - leftBound.position.x
	
	var target_x = fletnicka.current_note_normalized * extents + leftBound.position.x
	var diff = (target_x - position.x)
	# This slows down the sheep, caps the amount of movement it does
	var final_diff = min(abs(diff), MOVEMENT_SPEED) * sign(diff)
	
	if abs(final_diff) < 0.01: final_diff = 0
	
	if final_diff < 0: $Sheep.scale.x = -1.1
	elif final_diff > 0: $Sheep.scale.x = 1.1
	
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	# warning-ignore:return_value_discarded
	tween.tween_property(self, "position:x", position.x + final_diff, 0.1)
	
