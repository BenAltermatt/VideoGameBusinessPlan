extends Control

signal update_content(new)

var Message = load("res://Scripts/Message.gd")
var MessageHeader = load("res://Scenes/MessageHeader.tscn")

var container
var messager

var our_convos

# Called when the node enters the scene tree for the first time.
func _ready():
	our_convos = {}
	
	container = get_node("Control/ScrollContainer/VBoxContainer")
	messager = get_node("Control/Messager")
	
	for person in GameManager.cur_convos:
		for msg in GameManager.cur_convos[person]:
			if our_convos.has(person):
				our_convos[person].append(msg)
			else:
				our_convos[person] = [msg]
			
		var new_header = MessageHeader.instance()
		new_header.init(person, GameManager.update_convos[person])
		new_header.connect("conv_select", self, "handle_new_person")
		container.add_child(new_header)
	
	
	yield(get_tree(), "idle_frame")
	emit_signal("update_content", _any_new())


func handle_new_person(dec_unr, speaker):
	GameManager.update_convos[speaker] = false
	emit_signal("update_content", _any_new())
	$Control/Messager.new_msg(our_convos[speaker])

func _any_new():
	for user in GameManager.update_convos:
		if GameManager.update_convos[user]:
			return true
	return false
