extends KinematicBody

onready var rays = $"Rays"

export var speed = 5

export var turn_speed = 2

onready var target = $"/root/SceneManager/GameScene/Character Flashlight/Character"

func _physics_process(delta):
	turn(delta)
	move(delta)

func turn(delta):
	var rotation = transform.looking_at(target.global_translation, Vector3.UP).basis.get_rotation_quat()
	transform.basis = self.transform.basis.slerp(Basis(rotation), delta * turn_speed).orthonormalized()

func move(delta):
	translation -= transform.basis.z * speed * delta
