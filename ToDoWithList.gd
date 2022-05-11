extends Control

#loads up icons for buttons
onready var text1 = preload("res://Graphics/PlusButton.png")
onready var text2 = preload("res://Assets/trashcantemp.png")

#variables
var is_selected = false
var item


#hides buttons for moving items when scene is run
func _ready():
	$ToDoDown.hide()
	$DoingDown.hide()
	$DoingUp.hide()
	$DoneUp.hide()

#changes back to home screen when button is pressed
func _on_BackButton_pressed():
	get_tree().change_scene("res://World.tscn")

#adds item when there is text in the line editor and removes when there isnt and 
#an item in the list is selected
func _on_Button_pressed():
	if $Panel/VCont/HCont/LineEdit.text and not is_selected:
		add_item_todo()
		$Panel/VCont/HCont/LineEdit.clear()
	elif is_selected and $Panel/VCont/ToDo.is_anything_selected():
		remove_selected_items_todo()
	elif is_selected and $Panel/VCont/Doing.is_anything_selected():
		remove_selected_items_doing()
	elif is_selected and $Panel/VCont/Done.is_anything_selected():
		remove_selected_items_done()

#adds an item to the to do list
func add_item_todo():
	$Panel/VCont/ToDo.add_item($Panel/VCont/HCont/LineEdit.text, null, true)
	$Panel/VCont/ToDo.set_item_metadata( $Panel/VCont/ToDo.get_item_count()-1,{"active": false})

func add_item_backtodo():
	$Panel/VCont/ToDo.add_item(item, null, true)
	$Panel/VCont/ToDo.set_item_metadata( $Panel/VCont/ToDo.get_item_count()-1,{"active": false})

#adds an item to the doinglist
func add_item_doing():
	$Panel/VCont/Doing.add_item(item, null, true)
	$Panel/VCont/Doing.set_item_metadata( $Panel/VCont/Doing.get_item_count()-1,{"active": false})

#adds an item to the done list
func add_item_done():
	$Panel/VCont/Done.add_item(item, null, true)
	$Panel/VCont/Done.set_item_metadata( $Panel/VCont/Done.get_item_count()-1,{"active": false})

#removes an item from the to do list
func remove_selected_items_todo():
	var it = $Panel/VCont/ToDo.get_selected_items()[0]
	$Panel/VCont/ToDo.remove_item(it)
	is_selected = false
	check_button()
	$ToDoDown.hide()

#removes selected items from doing list
func remove_selected_items_doing():
	var it2 = $Panel/VCont/Doing.get_selected_items()[0]
	$Panel/VCont/Doing.remove_item(it2)
	is_selected = false
	check_button()
	$DoingDown.hide()
	$DoingUp.hide()

#removes selected items from done list
func remove_selected_items_done():
	var it3 = $Panel/VCont/Done.get_selected_items()[0]
	$Panel/VCont/Done.remove_item(it3)
	is_selected = false
	check_button()
	$DoneUp.hide()

#changes the button texture
func check_button():
	if is_selected:
		$Panel/VCont/HCont/Button.texture_normal = text2
	else:
		$Panel/VCont/HCont/Button.texture_normal = text1

#when text is entered into the line edit, checks button status
func _on_LineEdit_text_entered(new_text):
	_on_Button_pressed()


#changes button texture when an item is selected on todo list
func _on_ToDo_item_selected(index):
	item = $Panel/VCont/ToDo.get_item_text(index)
	is_selected = true
	$ToDoDown.show()
	check_button()

#changes button texture when item is selected in doing list
#and also sets var to the text in the item selected
func _on_Doing_item_selected(index):
	item = $Panel/VCont/Doing.get_item_text(index)
	is_selected = true
	$DoingDown.show()
	$DoingUp.show()
	check_button()

#changes button texture when item is selected in done list
#sets var item to the text in the item selected
func _on_Done_item_selected(index):
	item = $Panel/VCont/Done.get_item_text(index)
	is_selected = true
	$DoneUp.show()
	check_button()

#unselects list when new text is entered into the line editor
func _on_LineEdit_text_changed(new_text):
	if $Panel/VCont/ToDo.is_anything_selected():
		unselect_list_todo()
	if $Panel/VCont/Doing.is_anything_selected():
		unselect_list_doing()
	if $Panel/VCont/Done.is_anything_selected():
		unselect_list_done()

#unselects list
func unselect_list_todo():
	is_selected = false
	$Panel/VCont/ToDo.unselect_all()
	check_button()

func unselect_list_doing():
	is_selected = false
	$Panel/VCont/Doing.unselect_all()
	check_button()

func unselect_list_done():
	is_selected = false
	$Panel/VCont/Done.unselect_all()
	check_button()

#unselects list when nothing is selected
func _on_ToDo_nothing_selected():
	unselect_list_todo()
	$ToDoDown.hide()


#unselects list when nothing is selected
func _on_Doing_nothing_selected():
	unselect_list_doing()
	$DoingDown.hide()
	$DoingUp.hide()


#unselects list when nothing is selected
func _on_Done_nothing_selected():
	unselect_list_done()
	$DoneUp.hide()
	
#moves an item into doing from todo when pressed and hides the button
func _on_ToDoDown_pressed():
	add_item_doing()
	remove_selected_items_todo()
	$ToDoDown.hide()

#moves an item back to todo from doing
func _on_DoingUp_pressed():
	add_item_backtodo()
	remove_selected_items_doing()
	$DoingUp.hide()
	$DoingDown.hide()

#moves an item into done from doing
func _on_DoingDown_pressed():
	add_item_done()
	remove_selected_items_doing()
	$DoingUp.hide()
	$DoingDown.hide()

#moves an item into doing from done
func _on_DoneUp_pressed():
	add_item_doing()
	remove_selected_items_done()
	$DoneUp.hide()

#stores data in save file from lists when back button is pressed
func _on_ToDoWithList_tree_exiting():
	var ToDo = []
	#var ToDo2 = PoolStringArray(ToDo)
	for n in range(0,$Panel/VCont/ToDo.get_item_count()):
		ToDo.insert(n,$Panel/VCont/ToDo.get_item_text(n))
	var Doing = []
	#var Doing2 = PoolStringArray(Doing)
	for n in range(0,$Panel/VCont/Doing.get_item_count()):
		Doing.insert(n,$Panel/VCont/Doing.get_item_text(n))
	var Done = []
	#var Done2 = PoolStringArray(Done)
	for n in range(0,$Panel/VCont/Done.get_item_count()):
		Done.insert(n,$Panel/VCont/Done.get_item_text(n))
	var saveArray2 = [ToDo, Doing, Done]
	var file = File.new()
	file.open("user://save_game_list.dat", File.WRITE)
	file.store_var(saveArray2)
	file.close()

#loads data from save file into lists when scene is entered
func _on_ToDoWithList_tree_entered():
	var file = File.new()
	file.open("user://save_game_list.dat", File.READ)
	var content = file.get_var()
	file.close()
	print("Test")
	if content == null:
		print("Test2")
		pass 
	else:
		print("Test3")
		var ToDo = content[0]
		print("Print ToDo: ", ToDo, ToDo.size())
		var Doing  = content[1]
		print("Print Doing: ", Doing, Doing.size())
		var Done  = content[2]
		print("Print Done: ", Done, Done.size())
		for n in range(0, ToDo.size()):
			print("In Loop")
			print("ToDo[n]", ToDo[n], n)
			$Panel/VCont/ToDo.add_item(ToDo[n], null, true)
		for n in range(0, Doing.size()):
			$Panel/VCont/Doing.add_item(Doing[n], null, true)
		for n in range(0, Done.size()):
			$Panel/VCont/Done.add_item(Done[n], null, true)

#unselects lists and hides buttons when line editor is entered
func _on_LineEdit_focus_entered():
	unselect_list_todo()
	unselect_list_doing()
	unselect_list_done()
	$ToDoDown.hide()
	$DoingDown.hide()
	$DoingUp.hide()
	$DoneUp.hide()
