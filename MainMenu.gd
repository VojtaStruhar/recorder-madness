extends Control

onready var fletnicka = $MicrophoneInput

func _process(delta):
	print(fletnicka.current_note)
	$VBoxContainer/NoteLabel.text = NoteFrequencies.names[round(fletnicka.current_note)]
	$VBoxContainer/PercentageSign.text = str(round(fletnicka.current_note_relative * 100) / 100.0)
