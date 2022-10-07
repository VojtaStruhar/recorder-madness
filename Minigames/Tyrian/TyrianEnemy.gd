extends Node2D

onready var animationPlayer = $AnimationPlayer

func _on_Area2D_area_entered(area):
	print("area entered enemy plane")
	animationPlayer.play("Death")
