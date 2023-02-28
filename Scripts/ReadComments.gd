extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const COMMENT_TEXT_PATH = "res://Scripts/comments.txt"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open(COMMENT_PATH, File.READ)
	var content = file.get_as_text()
	file.close()

	Comment = load(COMMENT_OBJECT_PATH)

	comments = [] # this is where the comments are stored

	# now we want to initialize the comments from our file
	var blocks = content.split(";")
	for block in blocks:
		# the comment file should parse the text we pass in 
		# as a single "comment" block
		comments.append(Comment.new(block.strip()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
