tool
extends EditorScript

# it should be noted that these files cannot have semicolons or newlines within content of comments
const COMMENT_TEXT_PATH = "res://Scripts/Comments.txt"
const COMMENT_OBJECT_PATH = "res://Scripts/Comment.gd"
const VIDEO_TEXT_PATH = "res://Scripts/Videos.txt"
const VIDEO_OBJECT_PATH = "res://Scripts/Video.gd"
const EVENT_TEXT_PATH = "res://Scripts/StoryEvents.txt"
const EVENT_OBJECT_PATH = "res://Scripts/StoryEvent.gd"
const MESSAGE_TEXT_PATH = "res://Scripts/Messages.txt"
const MESSAGE_OBJECT_PATH = "res://Scripts/Message.gd"

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
		if len(block.strip_edges()) != 0:
			var event = StoryEvent.new(block)
			
			if events.has(event.og_sl):
				events[event.og_sl].append(event)
			else:
				events[event.og_sl] = [event]

	return events
	
static func read_in_messages():
	var Message = load(MESSAGE_OBJECT_PATH)
	var file = File.new()
	file.open(MESSAGE_TEXT_PATH, File.READ)
	var blocks = file.get_as_text().split(";")
	
	var messages = {}
	for block in blocks:
		if len(block.strip_edges()) != 0:
			var message = Message.new(block)
			
			if messages.has(message.sl):
				messages[message.sl].append(message)
			else:
				messages[message.sl] = [message]
				
	return messages
	
func _run():
	var messages = read_in_messages()
	for key in messages:
		for ev in messages[key]:
			ev.print_message()

