extends Node2D

onready var animationPlayer = $AnimationPlayer

export var speed = 150

func _ready():
	$Explosion.visible = false

func _process(delta):
	position.x -= speed * delta

func _on_Area2D_area_entered(area):
	animationPlayer.play("Death")
