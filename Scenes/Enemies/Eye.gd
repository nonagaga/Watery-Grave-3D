extends Spatial

onready var head = $"/root/SceneManager/GameScene/Character Flashlight/Character/Head"

func _physics_process(delta):
	look_at(head.global_translation, Vector3.UP)
	
