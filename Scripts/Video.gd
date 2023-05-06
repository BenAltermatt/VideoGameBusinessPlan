const VIDEO_FILE_PATH = "res://VideoFiles/"
const THUMBNAIL_PATH = "res://VideoThumbnails/"

class_name YTVideo

var title : String = "NO_TITLE"
var user : String = "NO_USER"
var desc : String = "NO_DESCRIPTION"
var video_fname : String = "NO_FILENAME"
var thumbnail_fname : String = "NO_FILENAME"
var changes = {}
var sl = "NO_STORYLINE"
var time_thresh = -1


func _init(block=null):
	assert(block != null, "Block needs an initial value")
	
	# lets split up the blocks by lines
	var lines = block.split("\n")
	
	# the title name and the user are going to be within the first line
	var top_line = lines[0].strip_edges()
	
	# lets parse the threshold values
	var start = top_line.find("(")
	var end = top_line.find(")", start + 1)
	var params = top_line.substr(start + 1, end - 1).to_lower().split(",")
	sl = params[1].strip_edges()
	time_thresh = int(params[0].strip_edges())
	
	
	# next is the title
	start = top_line.find("\"")
	end = top_line.rfind("\"")
	title = top_line.substr(start + 1, end - 1)
	end = title.rfind("\"")
	title = title.substr(0, end)
	
	# now we want to go through and handle the parsing of each attribute
	for line_ind in range(1, len(lines)):
		_handle_attr(lines[line_ind].strip_edges())
		
func _handle_attr(line:String):
	# cut off the dash
	var subs = line.substr(line.find("-") + 1).split(":")
	var type = subs[0].to_lower().strip_edges()
	var val = ""
	for sub_i in range(1, len(subs)):
		val += subs[sub_i]
	
	val = val.strip_edges()
	
	# now we should find out which attribute we are defining
	match type:
		"user":
			_read_user(val)
		"tfile":
			_read_thumb(val)
		"vfile":
			_read_vfile(val)
		"desc":
			_read_desc(val)
		"change":
			_read_change(val)
		_:
			assert(false, "Illegal video argument provided %s" % type)

func _read_user(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	user = content.substr(start + 1, end - 1)
	
func _read_desc(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	desc = content.substr(start + 1, end - 1)
	
func _read_thumb(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	thumbnail_fname = content.substr(start + 1, end - 1)
	
	
func _read_change(content:String):
	var start = content.find("(")
	var end = content.rfind(")")
	var vals = content.substr(start + 1, end - 1).split(",")
	
	for val in vals:
		var sl_tag = val.split("=")[0].strip_edges()
		var change = int(val.split("=")[1].strip_edges())
		
		if changes.has(sl_tag):
			changes[sl_tag] += change
		else:
			changes[sl_tag] = change
	
func _read_vfile(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	video_fname = content.substr(start + 1, end - 1)
	
# this should be able to get the video stream of a video file
func load_vidstream():
	return load(VIDEO_FILE_PATH + video_fname)

func print_video():
	print("(time_thresh, sl_tag) are (%d, %s)" % [time_thresh, sl])
	print("Title: %s" % title)
	print("User: %s" % user)
	print("Description: %s" % desc)
	print("Vidfile and TFile : %s, %s" % [video_fname, thumbnail_fname])
	var changes_str = "Changes are: "
	for key in changes:
		changes_str += ("%s = %d, " % [key, changes[key]])
	print(changes_str.substr(0, len(changes_str) - 2)) 
	

func load_texture() -> ImageTexture:
	var retImg : ImageTexture = ImageTexture.new()
	var img : Image = Image.new()
	
	var err = img.load(THUMBNAIL_PATH + thumbnail_fname)
	if err != OK:
		assert(false, "Failed to load in a profile pic asset. Filename %s" % thumbnail_fname)
		return retImg
	
	retImg.create_from_image(img)
	return retImg
