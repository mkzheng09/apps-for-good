extends Control

#changes back to home screen when button is pressed
func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://World.tscn")
