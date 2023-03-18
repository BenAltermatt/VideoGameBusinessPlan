# it should be noted that these files cannot have semicolons or newlines within content of comments

const COMMENT_TEXT_PATH = "res://Scripts/Comments.txt"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"
const VIDEO_TEXT_PATH = "res://Scripts/Videos.txt"
const VIDEO_OBJECT_PATH = "res://Scripts/Video.gd"

# This is in run rn, but we'll make it a method we can just
# call later
static func read_in_comments():
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
			

	return comments

static func read_in_videos():
	var Video = load(VIDEO_OBJECT_PATH)
	var file = File.new()
	file.open(VIDEO_TEXT_PATH, File.READ)
	var content = file.get_as_text()
	file.close()
	
	var blocks = content.split(";")
	var videos = []
	for block in blocks:
		if len(block.strip_edges()) > 0:
			videos.append(Video.new(block.strip_edges()))
	
	return videos


func _run():
	read_in_videos()
