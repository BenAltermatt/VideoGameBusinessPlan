tool
extends EditorScript

const VIDEO_FILE_PATH = "res://VideoFiles/"
const THUMBNAIL_PATH = "res://Thumbnails/"

class_name YTVideo

var title : String = "NO_TITLE"
var user : String = "NO_USER"
var desc : String = "NO_DESCRIPTION"
var video_fname : String = "NO_FILENAME"
var vid : VideoStream = VideoStream.new()
var thumbnail_fname : String = "NO_FILENAME"
var thumbnail : ImageTexture = ImageTexture.new()
var good_thresh : int = -1
var end_a_thresh : int = -1
var time_thresh : int = -1
var good_change : int = -1
var end_a_change : int = -1


func __init__(block: String):
	# lets split up the blocks by lines
	var lines = block.split("\n")
	
	# the title name and the user are going to be within the first line
	var top_line = lines[0].strip_edges()
	
	# lets parse the threshold values
	var start = top_line.find("(")
	var end = top_line.find(")", start + 1)
	var thresh_s = top_line.substr(start + 1, end - 1)
	var thresh_ints = thresh_s.split(",")
	good_thresh = int(thresh_ints[0].strip_edges())
	end_a_thresh = int(thresh_ints[1].strip_edges())
	time_thresh = int(thresh_ints[2].strip_edges())
	
	# next is the title
	start = top_line.find("\"")
	end = top_line.rfind("\"")
	title = top_line.substr(start + 1, end - 1)
	
	# now we want to go through and handle the parsing of each attribute
	for line_ind in range(1, len(lines)):
		_handle_attr(lines[line_ind].strip_edges())
		
func _handle_attr(line:String):
	# cut off the dash
	var subs = line.substr(line.find("-") + 1).split(":")
	var type = subs[0].to_lower()
	var val = ""
	for sub_i in range(1, len(subs)):
		val += subs[sub_i]
	
	val = val.strip_edges("")
	
	# now we should find out which attribute we are defining
	match subs:
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
			assert(false, "Illegal video argument provided %s" % subs)

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
	
	# now we want to actually load in the file as well
	thumbnail = _load_texture(thumbnail_fname)
	
func _read_change(content:String):
	var start = content.find("(")
	var end = content.rfind(")")
	var vals = content.substr(start + 1, end - 1).split(",")
	
	good_change = int(vals[0].strip_edges())
	end_a_change = int(vals[1].strip_edges())
	
func _read_vfile(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	video_fname = content.substr(start + 1, end - 1)
	
# this should be able to get the video stream of a video file
func load_vidstream():
	return load(VIDEO_FILE_PATH + video_fname)

func print_video():
	print("(good_thresh, end_a_thresh, time_thresh) are (%d, %d, %d)" % [good_thresh, end_a_thresh, time_thresh])
	print("Title: %s" % title)
	print("User: %s" % user)
	print("Description: %s" % desc)
	print("Vidfile and TFile : %s, %s" % [video_fname, thumbnail_fname])
	print("(good_change, end_a_change) are (%d, %d)" % [good_change, end_a_change])
	

func _load_texture(filename : String) -> ImageTexture:
	var retImg : ImageTexture = ImageTexture.new()
	var img : Image = Image.new()
	
	var err = img.load(THUMBNAIL_PATH + filename)
	if err != OK:
		assert(false, "Failed to load in a profile pic asset. Filename %s" % filename)
		return retImg
	
	retImg.create_from_image(img)
	return retImg
