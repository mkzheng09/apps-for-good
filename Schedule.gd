extends Node2D

var y = 66
var x = 300

func _on_Button_pressed():
	
	var new_item_scn = load("res://NoLerp.tscn")
	var item = new_item_scn.instance()
	item.set_position(Vector2(x,y))
	get_node("Tasks").add_child(item)
