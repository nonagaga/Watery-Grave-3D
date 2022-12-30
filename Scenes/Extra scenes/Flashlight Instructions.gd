extends Sprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==true:
		self.visible = false
	else:
		if Input.is_action_just_pressed("Flashlight Toggle")&&self.visible==false:
			self.visible = true

