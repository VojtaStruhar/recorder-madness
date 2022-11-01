extends Node2D

onready var bpmTimer = $"%BpmTimer"
onready var playerSprite = $YSort/SheepPlayer/Sheep

var song_resource: SongResource = null

var player_score = 0

func _ready():
	song_resource = SceneManager.songResource
	$StartGameTimer.start()

func start_game():
	if song_resource == null: 
		printerr("No song assigned for minigame")
		SceneManager.change_scene(SceneManager.Screen.MAIN_MENU)
		return
	
	print("GAME STARTED, bpm: ", song_resource.bpm)
	bpmTimer.wait_time = 60.0 / song_resource.bpm
	bpmTimer.start()
	
	$Grass.speed = song_resource.bpm * 1.5
	$Grass.is_running = true
	
	playerSprite.playing = true

func _on_StartGameTimer_timeout():
	start_game()


func _on_MoneyScanner_area_entered(area):
	area.queue_free()
	player_score += 1
	$"%ScoreLabel".text = "Score: " + str(player_score)

# Called by the loot spawner when it gets to the end of the song
func finish_game():
	$FinishGameTimer.start()



func _on_FinishGameTimer_timeout():
	SceneManager.game_over(player_score, SceneManager.Screen.SONG)

# Player rammed into something (tree?)
func _on_ObstacleScanner_area_entered(area):
	SceneManager.game_over(player_score, SceneManager.Screen.SONG)
