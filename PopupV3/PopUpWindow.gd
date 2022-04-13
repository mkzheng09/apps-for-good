extends Control

onready var popup = get_node("WindowDialog")
onready var popup2 = get_node("WindowDialog2")
onready var popup3 = get_node("WindowDialog3")
onready var help = get_node("Help")
onready var tips = get_node("Tips")
onready var suggestions = get_node("Suggestions")


func _on_Help_button_up():
	popup.visible=true

func _on_Tips_button_up():
	popup2.visable=true

func _on_Suggestions_button_up():
	popup3.visable=true
