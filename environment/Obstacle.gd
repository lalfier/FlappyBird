extends Node2D

signal score

onready var point_sfx = $PointSfx

const SPEED = 215

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()
#		print("Obstacle deleted!")

func _on_Wall_body_entered(body):
	if body is Player:
#		print("Player hit wall!")
		if body.has_method("die"):
			body.die()

func _on_ScoreArea_body_exited(body):
	if body is Player && body.alive:
#		print("Player scored!")
		point_sfx.play()
		emit_signal("score")
