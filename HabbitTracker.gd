extends Node2D

#changes to home screen when back button pressed
func _on_BackButton_pressed():
	get_tree().change_scene("res://World.tscn")

#saves slider number when tree is exited (save game)
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

#reloads slider data when it is entered
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

#resets sliders at midnight for new day
func _on_Timer_habitreset():
	$Water/HSlider.value = 0
	$Exercise/HSlider.value = 0
	$Sleep/HSlider.value = 0
	$DailyHomework/HSlider.value = 0
	$Chores/HSlider.value = 0
