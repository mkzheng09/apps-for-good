extends Control

onready var menu = $PopupMenu

func createPopup():
	var habit
	#menu.set_as_minsize()
	menu.clear()
	menu.add_item("Type in the new habit you want to track.", 0)
	menu.add_item("Close", 1)
	menu.popup(Rect2(0,0, menu.rect_size.x, menu.rect_size.y))
	
	#while $PopupMenu/LineEdit == null:
	
	while $PopupMenu/LineEdit.text == null:
		habit = null
	if $PopupMenu/LineEdit.text != null:
		habit = $PopupMenu/LineEdit.text
		return habit
