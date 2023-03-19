extends Node

var current_screen = 0
var comment_val = null
var content_val = null

# Called when the node enters the scene tree for the first time.
func _ready():
	comment_val = get_node("PanelContainer/Control2")
	content_val = get_node("PanelContainer/Control3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if delta > 1:
		print("comment_val.visibleAHAHAH")
		comment_val.visible = !comment_val.visible
		content_val.visible = !content_val.visible

func _on_ContentButton_pressed():
	print("let me die")
	
	if current_screen == 0: # comment screen
		comment_val.visible = false
		content_val.visible = true
	current_screen = 1


func _on_Comment_pressed():
	print("{Pisss}")
	if current_screen == 1: # content screen
		comment_val.visible = true
		content_val.visible = false
	current_screen = 0


func _on_TextureButton_pressed():
	print("Button pressed")
