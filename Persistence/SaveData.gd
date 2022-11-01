extends Resource
class_name SaveData

export var microphone_choice: String = "Default"
export var highscore_tyrian: int = 0
export var highscore_song: int = 0

func _init(mic = "Default", hs_t = 0, hs_s = 0):
	microphone_choice = mic
	highscore_tyrian = hs_t
	highscore_song = hs_s
