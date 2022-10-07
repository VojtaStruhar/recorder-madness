extends Node

enum Screen {
	MAIN_MENU,
	TYRIAN
}
# These have to be in the same order as their enum counterparts
const _scene_paths = [
	"res://MainMenu.tscn",
	"res://Minigames/Tyrian/TyrianLevel.tscn"
]

func change_scene(screen_index: int):
	var error = get_tree().change_scene(_scene_paths[screen_index])
	
	if error != null:
		var path_segments = _scene_paths[screen_index].split("/")
		print("Failed to change scene to " + path_segments[path_segments.size() - 1])
