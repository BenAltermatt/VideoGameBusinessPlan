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
	var type = subs[0]
	var val = ""
	for sub_i in range(1, len(subs)):
		val += subs[sub_i]
	
	
	
	
	return
