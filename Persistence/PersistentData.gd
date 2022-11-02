extends Node

const SAVE_PATH = "res://Persistence/SaveData.tres"

var microphone_choice = "Default"

var highscore_tyrian: int = 0
var highscore_songs: Dictionary = {}

func _enter_tree():
	var loaded: SaveData = ResourceLoader.load(SAVE_PATH)
	if loaded == null: return
	
	microphone_choice = loaded.microphone_choice
	highscore_tyrian = loaded.highscore_tyrian
	highscore_songs = loaded.highscore_songs

func _exit_tree():
	var data = SaveData.new()
	data.microphone_choice = self.microphone_choice
	data.highscore_songs = highscore_songs
	data.highscore_tyrian = highscore_tyrian
	
	var result = ResourceSaver.save(SAVE_PATH, data)
	print("Saving result: ", "OK" if result == OK else str(result))
