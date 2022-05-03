extends Node2D

var y = 100
var x = 290

func _on_Button_pressed():
	
	var new_item_scn = load("res://NoLerp.tscn")
	var item = new_item_scn.instance()
	item.set_position(Vector2(x,y))
	get_node("Tasks").add_child(item)


func _on_BackHome_pressed():
	get_tree().change_scene("res://World.tscn")
