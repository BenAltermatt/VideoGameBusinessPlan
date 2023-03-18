extends Node


# Declare member frdrrrrrvariables here. Examples:
# var a = 2
# var b = "text"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"

var Comment = load(COMMENT_OBJECT_PATH)

var myComment

func init(rend_com):
	assert(rend_com != null, "A comment needs values to be passed to properly display.")
	
	myComment = rend_com

# Called when the node enters the scene tree for the first time.
func _ready():
	myComment.print_comment()
	
	
	# we need to find the comment's parts
	get_node("Visual Comment/Pfp").texture = myComment.load_texture()
	get_node("Visual Comment/Username").text = myComment.user
	get_node("Visual Comment/Comment Content").text = myComment.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
