extends Node2D

var song_resource: SongResource = preload("res://Assets/Songs/bday_100bpm.tres")

var player_score = 0

func _ready():
	$StartGameTimer.start()

func start_game():
	if song_resource == null: return
	
	print("GAME STARTED, bpm: ", song_resource.bpm)
	$ObstacleSpawner/BpmTimer.wait_time = 60.0 / song_resource.bpm
	$ObstacleSpawner/BpmTimer.start()
	
	$Grass.speed = song_resource.bpm * 1.5
	$Grass.is_running = true
	
	$SheepPlayer/Sheep.playing = true

func _on_StartGameTimer_timeout():
	start_game()


func _on_MoneyScanner_area_entered(area):
	area.queue_free()
	player_score += 1

# Called by the loot spawner when it gets to the end of the song
func finish_game():
	$FinishGameTimer.start()

func _on_FinishGameTimer_timeout():
	SceneManager.game_over(player_score, SceneManager.Screen.SONG)
