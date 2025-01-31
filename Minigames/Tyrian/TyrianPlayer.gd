extends Node2D

onready var upperBound = $"../UpperBound"
onready var lowerBound = $"../LowerBound"
onready var fletnicka := $"../MicrophoneInput"
onready var noteLabel := $Label
onready var firePoint := $FirePoint

onready var bulletTemplate = preload("res://Minigames/Tyrian/TyrianBullet.tscn")

onready var extents: float = lowerBound.position.y - upperBound.position.y

func _process(_delta):
	var note: float = 1 - fletnicka.current_note_normalized
	
	var target_y = note * extents + upperBound.position.y
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	# The tween duration is very arbitrary. Just a value that seems smooth when the spaceship moves.
	tween.tween_property(self, "position:y", target_y, 0.1)
	
	noteLabel.text = NoteFrequencies.names[round(fletnicka.current_note)]

func _on_Timer_timeout():
	var bullet = bulletTemplate.instance()
	get_parent().add_child(bullet)
	bullet.global_position = firePoint.global_position
