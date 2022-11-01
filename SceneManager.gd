extends Node

enum Screen {
	MAIN_MENU,
	TYRIAN,
	GAME_OVER,
	SONG,
	SONG_SELECTION
}
# These have to be in the same order as their enum counterparts
const _scene_paths = [
	"res://Minigames/Menus/MainMenu.tscn",
	"res://Minigames/Tyrian/TyrianLevel.tscn",
	"res://Minigames/Menus/ScoreScreen.tscn",
	"res://Minigames/SongLevel/SongMinigame.tscn",
	"res://Minigames/Menus/SongSelectionMenu.tscn"
]

# For game over screen (and the "play again" option)
var lastGame = { "score": 0, "minigame": Screen.MAIN_MENU }
# For launching the "play certain song" minigame
var songResource: SongResource = null

func game_over(score: int, minigame: int):
	lastGame.score = score
	lastGame.minigame = minigame
	change_scene(Screen.GAME_OVER)

func change_scene(screen_index: int):
	var error = get_tree().change_scene(_scene_paths[screen_index])
	
	if error != 0:
		var path_segments = _scene_paths[screen_index].split("/")
		printerr("Failed to change scene to " + path_segments[path_segments.size() - 1])
		printerr(error)

func _enter_tree():
	randomize()
