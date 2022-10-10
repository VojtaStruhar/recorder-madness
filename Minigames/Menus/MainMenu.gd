extends Control

onready var fletnicka = $MicrophoneInput

func _process(_delta: float):
	$"%NoteLabel".text = NoteFrequencies.names[round(fletnicka.current_note)].split(" ")[0]

