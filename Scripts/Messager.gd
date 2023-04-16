extends Control

export(int) var margins # we need to know how much room to make

var container
var ToMessage = load("res://Scenes/ToMessage.tscn")
var FromMessage = load("reas://Scenes/FromMessage.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var container = get_node("Control/ScrollContainer/VBoxContainer")
	container.add_constant_override("separation", margins)
	
	var testMsg = ToMessage.instance()
	testMsg.init("Hello\nEverybody", margins, true)
	container.add_child(testMsg)
