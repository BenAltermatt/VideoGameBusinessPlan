# it should be noted that these files cannot have semicolons or newlines within content of comments

tool 
extends EditorScript

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const COMMENT_TEXT_PATH = "res://Scripts/comments.txt"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"

# Called when the node enters the scene tree for the first time.
# func _ready():

	# var Comment = load(COMMENT_OBJECT_PATH)
	# var file = File.new()
	# file.open(COMMENT_TEXT_PATH, File.READ)
	# var content = file.get_as_text()
	# file.close()

	# var comments = [] # this is where the comments are stored

	# # now we want to initialize the comments from our file
	# var blocks = content.split(";")
	# for block in blocks:
	# 	# the comment file should parse the text we pass in 
	# 	# as a single "comment" block
	# 	comments.append(Comment.new(block.strip()))




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _run():
	var Comment = load(COMMENT_OBJECT_PATH)
	var file = File.new()
	file.open(COMMENT_TEXT_PATH, File.READ)
	var content = file.get_as_text()
	file.close()

	var blocks = content.split(";")
	var comments = []

	for block in blocks:
		if len(block.strip_edges()) > 0:
			comments.append(Comment.new(block.strip_edges()))

	for comment in comments:
		comment.print_comment()
		print()


# 	var input = "(10, 20, 30) \"Piss ass\"\n - User: \"Asshole\"\n - Pfp: \"pissass.png\"\n - Cmt: \"Certified dickhead\" (11, -3)"

# 	var new_com = Comment.new(input)

# 	new_com.print_comment()
