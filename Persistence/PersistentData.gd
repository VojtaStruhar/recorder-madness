extends Node

const SAVE_PATH = "res://Persistence/SaveData.tres"

var microphone_choice = "Default"
var highscores = {
	"tyrian": 0,
	"song": 0
}

func _enter_tree():
	print("PersistenceData entered tree")
	var loaded: SaveData = ResourceLoader.load(SAVE_PATH)
	if loaded == null: return
	
	microphone_choice = loaded.microphone_choice
	highscores.tyrian = loaded.highscore_tyrian
	highscores.song = loaded.highscore_song

func _exit_tree():
	print("PersistenceData exit tree")
	var data = SaveData.new()
	data.microphone_choice = self.microphone_choice
	data.highscore_song = highscores.song
	data.highscore_tyrian = highscores.tyrian
	
	var result = ResourceSaver.save(SAVE_PATH, data)
	print("Saving result: ", "OK" if result == OK else str(result))
