extends KinematicBody
#what up nerd

onready var mouse_sensitivity = $"/root/SceneManager".Globals["sensitivity"]

export var speed = 15

export var swim_up_divider = 1.5 #this value was originally in like 34 but i changed it to an export variable for quick moving

onready var head = $Head

var h_acceleration = 2

var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	
	#direction is the force applied every frame based on player inputs
	direction = Vector3()
	
	direction += head.global_transform.basis.z * ((-Input.get_action_strength("move_forward")) + Input.get_action_strength("move_backward"))
	direction += head.global_transform.basis.x * (-Input.get_action_strength("move_left")) + head.global_transform.basis.x * Input.get_action_strength("move_right")
	
	direction += Vector3.UP * (Input.get_action_strength("swim_up") - Input.get_action_strength("swim_down")) #I believed that all possible adjustable values should not be magic numbers
	
	#normalization changes vector length to 1 to prevent unnatural speed
	direction = direction.normalized()
	
	h_velocity += direction * speed * delta
	h_velocity = h_velocity.linear_interpolate(Vector3.ZERO, h_acceleration*delta)
	
	#move_and_slide is a built in method that applies a linear velocity and checks for collisions
	#ie if this method isn't used, no collisions!
	h_velocity = move_and_slide(h_velocity, Vector3.UP)
