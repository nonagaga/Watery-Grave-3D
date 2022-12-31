extends KinematicBody

onready var rays = $"Rays"

export var speed = 200

onready var target = $"/root/SceneManager/GameScene/Character Flashlight/Character"

func _physics_process(delta):
	var direction = global_translation.direction_to(target.global_translation)
	look_at(target.global_translation, Vector3.UP)
	move_and_slide(direction*speed*delta, Vector3.UP)
