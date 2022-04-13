extends Control

onready var text1 = preload("res://Assets/ok_bt1.png")
onready var text2 = preload("res://Assets/ok_bt2.jpg")

var is_selected = false

func _ready():
	$Bkg/VBoxContainer/Panel/AnimatedSprite.play("default")

func _on_TextureButton_pressed():
	if $Bkg/VBoxContainer/HBoxContainer/LineEdit.text and not is_selected:
		add_item()
		$Bkg/VBoxContainer/HBoxContainer/LineEdit.clear()
	elif is_selected:
		remove_selected_items()

func add_item():
	$Bkg/VBoxContainer/ItemList.add_item($Bkg/VBoxContainer/HBoxContainer/LineEdit.text, null, true)
	$Bkg/VBoxContainer/ItemList.set_item_metadata($Bkg/VBoxContainer/ItemList.get_item_count()-1,{"active": false})

func remove_selected_items():
	var it = $Bkg/VBoxContainer/ItemList.get_selected_items()[0]
	$Bkg/VBoxContainer/ItemList.remove_item(it)
	is_selected = false
	check_button()

func check_button():
	if is_selected:
		$Bkg/VBoxContainer/HBoxContainer/TextureButton.texture_normal = text2
	else:
		$Bkg/VBoxContainer/HBoxContainer/TextureButton.texture_normal = text1



func _on_LineEdit_text_entered(new_text):
	_on_TextureButton_pressed()


func _on_ItemList_item_selected(index):
	is_selected = true
	check_button()

func _on_LineEdit_text_changed(new_text):
	if $Bkg/VBoxContainer/ItemList.is_anything_selected():
		unselect_list()

func unselect_list():
	is_selected = false
	$Bkg/VBoxContainer/ItemList.unselect_all()
	check_button()


func _on_ItemList_nothing_selected():
	unselect_list()

func _on_ItemList_item_activated(index):
	if $Bkg/VBoxContainer/ItemList.get_item_metadata(index)["active"] == false:
		$Bkg/VBoxContainer/ItemList.set_item_custom_bg_color(index, Color.darkgreen)
		$Bkg/VBoxContainer/ItemList.set_item_metadata(index, {"active": true})
	else:
		$Bkg/VBoxContainer/ItemList.set_item_custom_bg_color(index, Color(0,0,0,0))
		$Bkg/VBoxContainer/ItemList.set_item_metadata(index, {"active": false})
