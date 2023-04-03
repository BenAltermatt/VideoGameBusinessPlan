extends Node

const SINGLE_RESPONSE_PATH = "res://Scenes/SingleResponse.tscn"
const LOADER = "res://Scripts/ReadObjects.gd"

var Loader = load(LOADER)

signal successful_response(index, change_dict)
var comment # this is an array of responses we have to display
var glob_ind

# Called when the node enters the scene tree for the first time.
func init(com, ind):
	comment = com
	glob_ind = ind

func _ready():
	var Response = load(SINGLE_RESPONSE_PATH)
	
	var container = get_node("PanelContainer/ScrollContainer/VBoxContainer")
	
	# we need to go through and initialize all of the responses
	for resp_ind in range(len(comment.responses)):
		var new_resp = Response.instance()

		new_resp.init(comment.responses[resp_ind].text, resp_ind)
		new_resp.connect("responded",self,"_handle_responded")
		
		container.add_child(new_resp)
		


func _handle_responded(index):
	var resp = comment.responses[index]
	emit_signal("successful_response", glob_ind, resp.changes)
