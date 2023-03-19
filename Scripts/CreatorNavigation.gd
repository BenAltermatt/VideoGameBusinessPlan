extends Node

var current_screen = 1
var comment_val = null
var content_val = null

# Called when the node enters the scene tree for the first time.
func _ready():
	comment_val = get_node("PanelContainer/Control2")
	content_val = get_node("PanelContainer/Control3")

func _on_ContentButton_pressed():
	if current_screen == 0: # comment screen
		comment_val.visible = false
		content_val.visible = true
	current_screen = 1


func _on_Comment_pressed():
	if current_screen == 1: # content screen
		comment_val.visible = true
		content_val.visible = false
	current_screen = 0
