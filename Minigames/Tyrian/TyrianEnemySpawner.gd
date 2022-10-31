extends Node2D

onready var upperBound = $"../UpperBound"
onready var lowerBound = $"../LowerBound"

onready var enemyTemplate = preload("res://Minigames/Tyrian/TyrianEnemy.tscn")

var score = 0
var last_plane_speed = -1

func _on_Timer_timeout():
	var random_y = rand_range(upperBound.global_position.y + 10, lowerBound.global_position.y - 10)
	var enemy = enemyTemplate.instance()
	
	# Gradually increase the speed of the planes
	if last_plane_speed < 0: last_plane_speed = enemy.speed
	last_plane_speed += 5
	enemy.speed = last_plane_speed
	
	add_child(enemy)
	enemy.connect("death", self, "plane_died")
	enemy.global_position.y = random_y
	
	$Timer.wait_time = max($Timer.wait_time - 0.1, 1.1) # 1s is the shooting frequency, fastest spawn is 1.1
	$Timer.start()

func plane_died():
	score += 1
