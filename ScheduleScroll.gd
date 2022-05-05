extends Control

onready var text1 = preload("res://Assets/Add.png")
onready var text2 = preload("res://Assets/trashcantemp.png")

onready var taken = preload("res://Assets/takenSlot.png")
onready var empty = preload("res://Assets/emptySlot.png")

var start
var end
var duration
var activity
var is_selected = false
var ampm1_sel = false
var ampm2_sel = false

#variables for while loops in add_Event function
var n
var x
var count

var am1 = false
var pm1 = false

var am2 = false
var pm2 = false

var schedule_text = []
var schedule_icon = []

func _on_BackB_pressed():
	get_tree().change_scene("res://World.tscn")

#adds an item into the schedule
func _on_Add_pressed():
	if $ScrollContainer/VBox/HBox2/ActivityEdit.text and $ScrollContainer/VBox/HBox4/StartTimeEdit.text and $ScrollContainer/VBox/HBox4/EndTimeEdit.text and ampm1_sel and ampm2_sel and not is_selected:
		add_event()
		$ScrollContainer/VBox/HBox2/ActivityEdit.clear()
		$ScrollContainer/VBox/HBox4/StartTimeEdit.clear()
		$ScrollContainer/VBox/HBox4/EndTimeEdit.clear() 
		$ScrollContainer/VBox/HBox4/AMPM1.select(0)
		$ScrollContainer/VBox/HBox4/AMPM2.select(0)
		ampm1_sel = false
		ampm2_sel = false
	elif is_selected:
		remove_selected_items()

func remove_selected_items():
	var it = $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_selected_items()[0]
	$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_icon(it, empty)
	$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_text(it, "")
	is_selected = false
	check_button()

func check_button():
	if is_selected:
		$ScrollContainer/VBox/HBox2/Add.texture_normal = text2
	else:
		$ScrollContainer/VBox/HBox2/Add.texture_normal = text1

func add_event():
	activity = $ScrollContainer/VBox/HBox2/ActivityEdit.text
	start =  int($ScrollContainer/VBox/HBox4/StartTimeEdit.text)
	end =  int($ScrollContainer/VBox/HBox4/EndTimeEdit.text)
	
	if am1 and start < 6:
		print("Time frame is invalid")
		$Popup/InvalidTime.show()
		return
	
	if am2 and end < 6:
		print("Time frame is invalid")
		$Popup/InvalidTime.show()
		return
	
	
	if pm1 and start != 12:
		start = start + 12
		print("start", str(start))
		if start <= 6 or start >= 23:
			print("Time frame is invalid")
			$Popup/InvalidTime.show()
			return
	elif pm1 and start == 12:
		start = 12


	if pm2 and end != 12:
		end = end + 12
		print("end", str(end))
		if end <= 6 or end >= 23:
			print("Time frame is invalid")
			$Popup/InvalidTime.show()
			return
	elif pm2 and end == 12:
		end = 12
		print("end ", str(end))
	
	if start < end:
		duration = end - start
		print("duration", str(duration))
	else:
		print("Time frame is invalid")
		$Popup/InvalidTime.show()
		return
	
	n = start - 6
	x = 0
	count = 0
	
	#add check to make sure slots are empty before adding
	while x < duration:
		if $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_text(n).empty():
			count = count + 1
			print("count", str(count))
			print("duration", str(duration))
		x = x + 1
		n = n + 1
	
	n = start - 6
	if count == duration:
		var c = 0
		while c < duration:
			$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_icon(n, taken)
			$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_text(n, activity)
			n = n + 1
			c = c + 1
	else:
		print("Something is already scheduled")
		$Popup/AlrTaken.show()

#sets am or pm for start time of event
func _on_AMPM1_item_selected(index):
	ampm1_sel = true
	if $ScrollContainer/VBox/HBox4/AMPM1.get_item_text(index) == "AM":
		am1 = true
		pm1 = false
		print("AM")
	else:
		pm1 = true
		am1 = false
		print("PM")

#sets am or pm for end time of event
func _on_AMPM2_item_selected(index):
	ampm2_sel = true
	if $ScrollContainer/VBox/HBox4/AMPM2.get_item_text(index) == "AM":
		am2 = true
		pm2 = false
		print("AM")
	else:
		pm2 = true
		am2 = false
		print("PM")

func _on_ActivityEdit_text_entered(new_text):
	_on_Add_pressed()

func _on_ActivityEdit_text_changed(new_text):
	if $ScrollContainer/VBox/HBox3/VBox2/ItemList.is_anything_selected():
		unselect_list()

func _on_ItemList_item_selected(index):
	if $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_text(index).empty():
		return
	else:
		is_selected = true
		check_button()

func _on_ItemList_nothing_selected():
	unselect_list()

func unselect_list():
	is_selected = false
	$ScrollContainer/VBox/HBox3/VBox2/ItemList.unselect_all()
	check_button()

func _on_AlrTaken_confirmed():
	$Popup/AlrTaken.hide()

func _on_InvalidTime_confirmed():
	$Popup/InvalidTime.hide()

#resets the schedule at midnight
func _on_Timer_midnight():
	var i = 0
	while i < $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_count():
		$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_icon(i, empty)
		$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_text(i, "")
		i = i + 1

func _on_Control_tree_exiting():	
	for n in range (0,$ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_count()):
		if $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_text(n).empty():
			schedule_text.insert(n, "null")
		else:
			schedule_text.insert(n, $ScrollContainer/VBox/HBox3/VBox2/ItemList.get_item_text(n))
	
	#print(schedule_text)
	var file = File.new()
	file.open("user://save_game_schedule.dat", File.WRITE)
	file.store_var(schedule_text)
	file.close()

func _on_Control_tree_entered():
	var emptyicon = load("res://Assets/emptySlot.png")
	var takenicon = load("res://Assets/takenSlot.png")
	
	var file = File.new()
	file.open("user://save_game_schedule.dat", File.READ)
	var content = file.get_var()
	file.close()
	print("Test")
	if content == null:
		print("Test2")
		pass 
	else:
		#print("Print events: ", texts, texts.size())
		#var icons  = content[1]
		#print("Print icons: ", icons, icons.size())
		
		for n in range(0, content.size()):
			#print("In Loop")  
			if content[n] == "null":
				$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_icon(n, emptyicon)
				$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_text(n, "")
			else:
				$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_text(n, content[n])
				$ScrollContainer/VBox/HBox3/VBox2/ItemList.set_item_icon(n, takenicon)
		

