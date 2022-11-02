extends Control

func play_song(path: String): 
	SceneManager.songResource = load(path)
	SceneManager.change_scene(SceneManager.Screen.SONG)

func _on_HappyBday_pressed():
	play_song("res://Assets/Songs/Happy_bday.tres")

func _on_SuperTrooper_pressed():
	play_song("res://Assets/Songs/Abba_-_Super_Trooper.tres")

func _on_JohnCena_pressed():
	play_song("res://Assets/Songs/John_Cena_2.tres")

func _on_KometaBrno_pressed():
	play_song("res://Assets/Songs/Kometa_Brno.tres")

func _on_CrazyFrog_pressed():
	play_song("res://Assets/Songs/Crazy_Frog_Double.tres")
