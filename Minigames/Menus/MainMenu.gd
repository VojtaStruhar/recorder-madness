extends Control

onready var fletnicka = $MicrophoneInput

func _process(_delta: float):
	$"%NoteLabel".text = "-" if fletnicka.is_quiet else NoteFrequencies.names[round(fletnicka.current_note)].split(" ")[0]	
	$"%ErrorLabel".text = fletnicka.error_message


func _on_QuitButton_pressed():
	get_tree().quit()
