extends Node


# Declare member frdrrrrrvariables here. Examples:
# var a = 2
# var b = "text"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"

signal reply_intent(index)

var Comment = load(COMMENT_OBJECT_PATH)

var myComment
var index

func init(rend_com, ind):
	myComment = rend_com
	index = ind

# Called when the node enters the scene tree for the first time.
func _ready():
	# we need to find the comment's parts
	if (myComment != null):
		get_node("Panel/Pfp").texture = myComment.load_texture()
		get_node("Panel/Username").text = myComment.user
		get_node("Panel/Comment Content").text = myComment.text


func _on_TextureButton_pressed():
	if GameManager.num_responded >= GameManager.MAX_RESPOND:
		$PopupDialog.popup()
	else:
		GameManager.num_responded += 1
		emit_signal("reply_intent", index)
