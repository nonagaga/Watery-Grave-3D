extends KinematicBody

onready var rays = $"Rays"
onready var target = $"/root/SceneManager/GameScene/Character Flashlight/Character"

export var speed = 500
export var turn_speed = 2

export var detection_distance = 100
export var correction_strength = 1
export var fov = 45

enum {WANDERING_STATE,ATTACK_STATE}

var state = WANDERING_STATE

var velocity = Vector3.ZERO

func _physics_process(delta):
	new_pathfind(delta)
	if(target.translation.distance_to(translation) <= detection_distance):
		detect_player()
	else:
		state = WANDERING_STATE
	if state == ATTACK_STATE:
		turn(delta)
	move(delta)

func turn(delta):
	var rotation_transform = transform.looking_at(target.global_translation, Vector3.UP)
	var rotation_quat = rotation_transform.basis.get_rotation_quat()
	var curr_rotation_quat = transform.basis.get_rotation_quat()
	var interpolated_quat = curr_rotation_quat.slerp(rotation_quat, turn_speed * delta)
	transform.basis = Basis(interpolated_quat)

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

func _enemy_in_light():
	state = ATTACK_STATE

func detect_player():
	var direction_vector = global_translation.direction_to(target.global_translation)
	print(String(direction_vector.dot(transform.basis.z.normalized() * -1)) + " " + String(acos(deg2rad(fov))))
	if direction_vector.dot(transform.basis.z.normalized() * -1) > acos(deg2rad(fov)):
		state = ATTACK_STATE
	else:
		state = WANDERING_STATE
	
