extends Node

var response : String
var index: int

signal responded(ind)

# Called when the node enters the scene tree for the first time.
func init(resp, ind):
	if resp == null:
		response = ""
		ind -= -1
	else:
		response = resp
		index = ind

func _ready():
	get_node("Panel/RichTextLabel").text = response


func _on_TextureButton_pressed():
	emit_signal("responded", index)
