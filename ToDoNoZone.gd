extends Node2D

var xtodo = 243
var y = 45

var list = []

var done = false

func _on_AddItem_pressed():
	
	var new_item_scn = load("res://NoLerp.tscn")
	var item = new_item_scn.instance()
	item.set_position(Vector2(xtodo,y))
	get_node("List").add_child(item)
	
	

onready var popup = get_node("WindowDialog")

onready var help = get_node("Help")

func _on_Help_button_up():
	popup.visible=true


#func _on_ClearDone_timeout():
	#list = get_tree().get_nodes_in_group("items")
	#for task in list:
		#var xpos = task.get_position()
		#print(xpos)
		#if xpos.AXIS_X >= 400:
			#task.queue_free()
			#task.hide()



func _on_Back_pressed():
	get_tree().change_scene("res://World.tscn")
