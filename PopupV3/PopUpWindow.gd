extends Control

onready var popup = get_node("WindowDialog")

onready var help = get_node("Help")

func _on_Help_button_up():
	popup.visible=true

