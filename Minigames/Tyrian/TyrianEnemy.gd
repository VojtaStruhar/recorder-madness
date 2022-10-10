extends Node2D

onready var animationPlayer = $AnimationPlayer

export var speed = 150

signal death

func _ready():
	$Explosion.visible = false

func _process(delta):
	position.x -= speed * delta

func _on_Area2D_area_entered(area):
	emit_signal("death")
	animationPlayer.play("Death")
