extends Node2D

#Changes the scene to the Todo list by clicking on the To-Do List icon
func _on_ToDo_pressed():
	get_tree().change_scene("res://ToDoWithList.tscn")

#Changes the scene to the Todo list by moving the player to the To-Do List icon
func _on_ToDoObject_body_entered(body):
	get_tree().change_scene("res://ToDoWithList.tscn")


#Changes the scene to the Schedule by moving the player to the Schedule icon
func _on_Schedule_pressed():
	get_tree().change_scene("res://ScheduleScroll.tscn")

#Changes the scene to the Schedule by moving the player to the Schedule icon
func _on_ScheduleObject_body_entered(body):
	get_tree().change_scene("res://ScheduleScroll.tscn")


#Changes the scene to the Habit Tracker by clicking on the Habit Tracker icon
func _on_Habits_pressed():
	get_tree().change_scene("res://HabbitTracker.tscn")

#Changes the scene to the Habit Tracker by moving the player to the Habit Tracker icon
func _on_HabitObject_body_entered(body):
	get_tree().change_scene("res://HabbitTracker.tscn")


#Changes the scene to the Help Menu by clicking on the Help Menu icon
func _on_HelpMenu_pressed():
	get_tree().change_scene("res://HelpMenu.tscn")

#Changes the scene to the Help Menu by moving the player to the Help Menu icon
func _on_HelpObject_body_entered(body):
	get_tree().change_scene("res://HelpMenu.tscn")
