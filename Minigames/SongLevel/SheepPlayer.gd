extends Node2D

onready var leftBound = $"../LeftBound"
onready var rightBound = $"../RightBound"
onready var fletnicka = $"../MicrophoneInput"

export var MOVEMENT_SPEED = 100

func _physics_process(delta):
	var extents = rightBound.position.x - leftBound.position.x
	
	var target_x = fletnicka.current_note_normalized * extents + leftBound.position.x
	
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position:x", target_x, 0.1)
	
	
