extends Control

onready var fletnicka = $MicrophoneInput

func _process(delta):
	print(fletnicka.current_note)
	$VBoxContainer/Label.text = NoteFrequencies.names[round(fletnicka.current_note)]
