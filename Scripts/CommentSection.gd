# eventually, when the comment portion is activated or shown, we'll have some
# means by which to pass the chosen comments from the game state script to
# the comment section. For now, it'll be all the comments in the file.

extends Node

var COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"
var COMMENT_READER_PATH = "res://Scripts/ReadObjects.gd"
var VISUAL_COMMENT_PATH = "res://Scenes/Single Comment.tscn"
var RESPONSE_VISUAL_PATH = "res://Scenes/CommentResponses.tscn"

var read_coms = load(COMMENT_READER_PATH)
var SingleComment = load(VISUAL_COMMENT_PATH)
var Responses = load(RESPONSE_VISUAL_PATH)

var response_objs = []
var replies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# read in the comments (this is a temporary setup)	
	var comments = read_coms.read_in_comments()
	var container = get_node("PanelContainer/ScrollContainer/VBoxContainer")
	
	for c_ind in range(len(comments)):
		var com = SingleComment.instance()
		com.init(comments[c_ind], c_ind)
		com.connect("reply_intent",self,"_handle_comment_intent")
		container.add_child(com)
		
		var resp = Responses.instance()
		comments[c_ind].print_comment()
		resp.init(comments[c_ind], c_ind)
		resp.visible = false
		resp.connect("successful_response",self,"_handle_reply_finished")
		response_objs.append(resp)
		container.add_child(resp)
		

func _handle_comment_intent(index):
	if !replies.has(index):
		response_objs[index].visible = true

func _handle_reply_finished(index, good_change, bad_change):
	replies.append(index)
	response_objs[index].visible = false
	
	#handle the good and bad change signaling
	
	
