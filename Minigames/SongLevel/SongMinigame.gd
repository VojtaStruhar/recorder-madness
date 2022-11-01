extends Node2D

var song_resource: SongResource = preload("res://Assets/Songs/bday_100bpm.tres")

func _ready():
	$StartGameTimer.start()

func start_game():
	if song_resource == null: return
	
	print("GAME STARTED")
	$ObstacleSpawner/BpmTimer.wait_time = 60 / song_resource.bpm
	$ObstacleSpawner/BpmTimer.start()
	
	$Grass.speed = song_resource.bpm
	$Grass.is_running = true
	
	$SheepPlayer/Sheep.playing = true

func finish_game():
	pass


func _on_StartGameTimer_timeout():
	start_game()



func _on_MoneyScanner_area_entered(area):
	area.queue_free()
	print("+1")
