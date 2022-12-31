extends RichTextLabel

func _input(event):
	if event.is_action_pressed("Flashlight Toggle"):
		self.set_visible(false)
