extends Node2D


func _on_ToDo_pressed():
	get_tree().change_scene("res://ToDoNoZone.tscn")


func _on_Schedule_pressed():
	get_tree().change_scene("res://Schedule.tscn")


func _on_Habits_pressed():
	get_tree().change_scene("res://HabbitTracker.tscn")