extends SpotLight


export var light_accel = 8
onready var head = get_parent().get_node("Character/Head")
onready var raycast = $"RayCast"
onready var enemy = $"/root/SceneManager/GameScene/Enemy"

signal enemy_in_light

func _ready():
	raycast.cast_to.z = -spot_range
	connect("enemy_in_light",enemy,"_enemy_in_light")
	self.visible = false
	raycast.enabled = false

func _physics_process(delta):
	global_transform = global_transform.interpolate_with(head.global_transform, light_accel*delta)
	
	#the code below is to turn the flashlight on and off
	if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==true:
		self.visible = false
		raycast.enabled = false
	else:
		if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==false:
			self.visible = true
			raycast.enabled = true
	
	if raycast.is_colliding():
		if raycast.get_collider().name == "Enemy":
			emit_signal("enemy_in_light")
