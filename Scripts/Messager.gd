extends Control

export(int) var margins # we need to know how much room to make

var container
var ToMessage = load("res://Scenes/ToMessage.tscn")
var FromMessage = load("res://Scenes/FromMessage.tscn")
var Message = load("res://Scripts/Message.gd")

var messages = []

func init(pas_messages):
	messages = pas_messages

# Called when the node enters the scene tree for the first time.
func _ready():
	var container = get_node("Control/ScrollContainer/VBoxContainer")
	container.add_constant_override("separation", margins)
	
	for message in messages:
		var newMsg
		if message.to_player:
			newMsg = ToMessage.instance()
			newMsg.init(message.message, margins, true)
		else:
			newMsg = FromMessage.instance()
			newMsg.init(message.message, margins, false)
		
		container.add_child(newMsg)
