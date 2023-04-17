extends Control

signal update_content(new)

var Message = load("res://Scripts/Message.gd")
var MessageHeader = load("res://Scenes/MessageHeader.tscn")

var container
var messager

var num_unread
var our_convos

# Called when the node enters the scene tree for the first time.
func _ready():
	num_unread = 0
	our_convos = {}
	
	container = get_node("Control/ScrollContainer/VBoxContainer")
	messager = get_node("Control/Messager")
	
	for person in GameManager.cur_convos:
		var unread = GameManager.cur_convos[person][0][0]
		
		for msg in GameManager.cur_convos[person]:
			if our_convos.has(person):
				our_convos[person].append(msg[1])
			else:
				our_convos[person] = [msg[1]]
			
		if unread:
			num_unread += 1
			
		var new_header = MessageHeader.instance()
		new_header.init(person, unread)
		new_header.connect("conv_select", self, "handle_new_person")
		container.add_child(new_header)
	
	emit_signal("update_content", num_unread > 0)


func handle_new_person(dec_unr, speaker):
	if dec_unr:
		num_unread -= 1
		
		if num_unread == 0:
			emit_signal("update_content", false)
	$Control/Messager.new_msg(our_convos[speaker])
