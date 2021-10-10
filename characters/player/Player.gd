extends RigidBody2D
class_name Player

signal died

export var FLAP_FORCE = -200

const MAX_ROTATION_DEGREES = -30.0

onready var animator = $AnimationPlayer
onready var hit_sfx = $HitSfx
onready var wing_sfx = $WingSfx

var started = false
var alive = true

func _physics_process(_delta):
#	print(rotation_degrees)
	if Input.is_action_just_pressed("flap") && alive:
		if !started:
			start()
		flap()
	
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 3
		else:
			angular_velocity = 0

func start():
	if started: return
	started = true
	gravity_scale = 5.0
	animator.play("Flap")

func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8.0
	wing_sfx.play()

func die():
	if !alive: return
	alive = false
	animator.stop()
	hit_sfx.play()
	emit_signal("died")
#	print("Player died!")
