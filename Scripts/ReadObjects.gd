# it should be noted that these files cannot have semicolons or newlines within content of comments
const COMMENT_TEXT_PATH = "res://Scripts/Comments.txt"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"
const VIDEO_TEXT_PATH = "res://Scripts/Videos.txt"
const VIDEO_OBJECT_PATH = "res://Scripts/Video.gd"
const EVENT_TEXT_PATH = "res://Scripts/StoryEvents.txt"
const EVENT_OBJECT_PATH = "res://Scripts/StoryEvents.gd"

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

static func read_in_events():
	var StoryEvent = load(EVENT_OBJECT_PATH)
	var file = File.new()
	file.open(EVENT_TEXT_PATH, File.READ)
	var blocks = file.get_as_text().split(";")

	var events = {}
	for block in blocks:
		var event = StoryEvent.new(block)
		
		if events.has(event.og_sl):
			events[event.og_sl].append(event)
		else:
			events[event.og_sl] = [event]
			
	return events

func _run():
	var videos = read_in_videos()
	for vid in videos:
		vid.print_video()
		print()
