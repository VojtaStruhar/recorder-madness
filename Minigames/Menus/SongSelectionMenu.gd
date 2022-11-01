extends Control



func _on_HappyBday_pressed():
	SceneManager.songResource = load("res://Assets/Songs/Happy_bday.tres")
	SceneManager.change_scene(SceneManager.Screen.SONG)
