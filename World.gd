extends Node2D

#Changes the scene to the Todo list
func _on_ToDo_pressed():
	get_tree().change_scene("res://ToDoWithList.tscn")

#Changes the scene to the Schedule
func _on_Schedule_pressed():
	get_tree().change_scene("res://ScheduleScroll.tscn")

#Changes the scene to the Habit Tracker
func _on_Habits_pressed():
	get_tree().change_scene("res://HabbitTracker.tscn")

#Changes the scene to the Help Menu
func _on_HelpMenu_pressed():
	get_tree().change_scene("res://HelpMenu.tscn")
