extends Node2D

var x = 100
var y = 150

onready var node = get_node("PopupScene")

func _on_TouchScreenButton_pressed():
	var habit 
	
	while habit == null:
		habit = node.createPopup()
	if habit != null:
		var label = $Object/Label
		label.text = habit
	var new_slider = load("res://Object.tscn")
	var slider = new_slider.instance()
	slider.set_position(Vector2(x,y))
	y = y + 100
	get_node("Sliders").add_child(slider)
	


func _on_Home_pressed():
	get_tree().change_scene("res://World.tscn")
