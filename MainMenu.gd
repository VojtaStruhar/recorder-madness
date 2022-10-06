extends Control

onready var fletnicka = $MicrophoneInput

func _process(_delta: float):
	print(fletnicka.current_note)
	$"%NoteLabel".text = NoteFrequencies.names[round(fletnicka.current_note)]
	$"%PercentageSign".text = str(round(fletnicka.current_note_relative * 100) / 100.0)
	
