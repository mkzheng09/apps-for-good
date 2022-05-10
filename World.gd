extends Node2D

func _on_ToDo_pressed():
	get_tree().change_scene("res://ToDoWithList.tscn")

func _on_Schedule_pressed():
	get_tree().change_scene("res://ScheduleScroll.tscn")

func _on_Habits_pressed():
	get_tree().change_scene("res://HabbitTracker.tscn")


func _on_HelpMenu_pressed():
	get_tree().change_scene("res://HelpMenu.tscn")
