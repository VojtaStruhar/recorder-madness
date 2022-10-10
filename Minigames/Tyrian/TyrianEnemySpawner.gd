extends Node2D

onready var upperBound = $"../UpperBound"
onready var lowerBound = $"../LowerBound"

onready var enemyTemplate = preload("res://Minigames/Tyrian/TyrianEnemy.tscn")

var score = 0

func _on_Timer_timeout():
	var random_y = rand_range(upperBound.global_position.y + 10, lowerBound.global_position.y - 10)
	var enemy = enemyTemplate.instance()
	add_child(enemy)
	enemy.connect("death", self, "plane_died")
	enemy.global_position.y = random_y

func plane_died():
	score += 1
