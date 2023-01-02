extends KinematicBody

onready var rays = $"Rays"
onready var target = $"/root/SceneManager/GameScene/Character Flashlight/Character"

export var speed = 500
export var turn_speed = 2

var velocity = Vector3.ZERO

func _physics_process(delta):
	new_pathfind(delta)
	turn(delta)
	move(delta)

func turn(delta):
	var rotation = transform.looking_at(target.global_translation, Vector3.UP).basis.get_rotation_quat()
	transform.basis = transform.basis.slerp(Basis(rotation), delta * turn_speed).orthonormalized()

func move(delta):
	velocity = -transform.basis.z * speed * delta
	velocity = move_and_slide(velocity, Vector3.UP)

func get_weighted_ray(ray_name):
	var ray = rays.get_node(ray_name)
	var curr_distance = get_ray_distance(ray_name)
	var max_distance = abs(ray.cast_to.y)
	var ray_percentage = curr_distance/max_distance
	return 1 - ray_percentage

func new_pathfind(delta):
	rotate_y(deg2rad(get_weighted_ray("Right") - get_weighted_ray("Left")))
	rotate_x(deg2rad(get_weighted_ray("Up") - get_weighted_ray("Down")))

func get_ray_distance(ray_name):
	var ray = rays.get_node(ray_name)
	if(ray.is_colliding()):
		var origin = ray.global_transform.origin
		var collision_point = ray.get_collision_point()
		var distance = origin.distance_to(collision_point)
		return distance
	return abs(ray.cast_to.y)
