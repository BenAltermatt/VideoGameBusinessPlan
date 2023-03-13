# eventually, when the comment portion is activated or shown, we'll have some
# means by which to pass the chosen comments from the game state script to
# the comment section. For now, it'll be all the comments in the file.

extends Node

var COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"
var COMMENT_READER_PATH = "res://Scripts/ReadComments.gd"
var VISUAL_COMMENT_PATH = "res://Scenes/Single Comment.tscn"

var read_coms = load(COMMENT_READER_PATH)
var SingleComment = load(VISUAL_COMMENT_PATH)

# Called when the node enters the scene tree for the first time.
func _ready():
	# read in the comments (this is a temporary setup)	
	var comments = read_coms.read_in()
	var container = get_node("ScrollContainer/VBoxContainer")
	
	for comment in comments:
		var com = SingleComment.instance()
		com.init(comment)
	
		container.add_child(com)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
