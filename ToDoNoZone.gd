extends Node2D

var xtodo = 64
#var xdoing = 206
#var xdone = 343
var y = 60

var list = []

var done = false

func _on_AddItem_pressed():
	y = y + 60
	
	var new_item_scn = load("res://NoLerp.tscn")
	var item = new_item_scn.instance()
	item.set_position(Vector2(xtodo,y))
	get_node("List").add_child(item)


#func _on_ClearDone_timeout():
	#list = get_tree().get_nodes_in_group("items")
	#for task in list:
		#var xpos = task.get_position()
		#print(xpos)
		#if xpos.AXIS_X >= 400:
			#task.queue_free()
			#task.hide()

