extends Node2D

onready var upperBound = $"../UpperBound"
onready var lowerBound = $"../LowerBound"

onready var enemyTemplate = preload("res://Minigames/Tyrian/TyrianEnemy.tscn")

func _on_Timer_timeout():
	var random_y = rand_range(upperBound.position.y + 20, lowerBound.position.y - 20)
	var enemy = enemyTemplate.instance()
	add_child(enemy)
	enemy.position.y = random_y
