extends Control

onready var fletnicka = $MicrophoneInput

func _process(_delta: float):
	$"%NoteLabel".text = NoteFrequencies.names[round(fletnicka.current_note)]
	$"%PercentageSign".text = str(round(fletnicka.current_note_normalized * 100) / 100.0)
	
