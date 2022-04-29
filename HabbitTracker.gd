extends Node2D

#var x = 100
#var y = 150

#onready var node = get_node("PopupScene")

#func _on_TouchScreenButton_pressed():
	#var habit 
	
	#while habit == null:
	#	habit = node.createPopup()
	#if habit != null:
	#	var label = $Object/Label
	#	label.text = habit
	#var new_slider = load("res://Object.tscn")
	#var slider = new_slider.instance()
	#slider.set_position(Vector2(x,y))
	#y = y + 100
	#get_node("Sliders").add_child(slider)
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_HabbitTracker_tree_exiting():
	var water = $Water/HSlider.value
	var exercise = $Exercise/HSlider.value
	var sleep = $Sleep/HSlider.value
	var dailyHomework = $DailyHomework/HSlider.value
	var chores = $Chores/HSlider.value
	var saveArray = [water, exercise, sleep, dailyHomework, chores]
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_var(saveArray)
	file.close()

func _on_HabbitTracker_tree_entered():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_var()
	file.close()
	if content == null:
		pass
	else:
		$Water/HSlider.value = int(content[0])
		$Exercise/HSlider.value = int(content[1])
		$Sleep/HSlider.value = int(content[2])
		$DailyHomework/HSlider.value = int(content[3])
		$Chores/HSlider.value = int(content[4])
