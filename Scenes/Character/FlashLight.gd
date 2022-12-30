extends SpotLight


export var light_accel = 8
onready var head = get_parent().get_node("Character/Head")


func _physics_process(delta):
	global_transform = global_transform.interpolate_with(head.global_transform, light_accel*delta)
	
	#the code below is to turn the flashlight on and off
	if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==true:
		self.visible = false
	else:
		if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==false:
			self.visible = true
