# as of now you can't put new lines in comments or responses.
# I'll hopefully fix that later

# This class represents a single comment that can be displayed
# within the game

# These are all the things we can get out of a single 
# comment in a game

const PROFILE_PIC_PATH = "res://ProfilePics/"

class_name Comment

var user : String = "NO_NAME"
var pfp_str : String = "default.png"
var text : String = "NO_TEXT"
var good_thresh : int = 0
var end_a_thresh : int = 0
var time_thresh : int = 0
var responses = []


# I want to be able to parse a comment out of a string from a file
func _init(block=null):
	if(block == null):
		return
	
	var lines = block.split('\n')
	
	# we are going to handle the top line first as it includes most of our info
	_read_args(lines[0])
	_read_comm(lines[0])
	
	# Let's go through all of our attribute lines now
	for i in range(1, len(lines)):
		_read_attr(lines[i])

func __init__(block:String):
	# it might be easiest to split these into lines
	var lines = block.split('\n')
	
	# we are going to handle the top line first as it includes most of our info
	_read_args(lines[0])
	_read_comm(lines[0])
	
	# Let's go through all of our attribute lines now
	for i in range(1, len(lines)):
		_read_attr(lines[i])

	

func _read_args(top_line:String):
	var top_args = top_line.split(" ")
	
	# the first arg should be (num,
	var p_buf = top_args[0].right(1)
	good_thresh = int(p_buf.left(len(p_buf) - 1))
	
	#second should be num,
	p_buf = top_args[1]
	end_a_thresh = int(p_buf.left(len(p_buf) - 1))
	
	# third should be num)
	p_buf = top_args[2]
	time_thresh = int(p_buf.left(len(p_buf) - 1))

func _read_comm(top_line:String):
	var start = top_line.find("\"")
	var end = top_line.rfind("\"")
	text = top_line.substr(start + 1, end - start - 1)
	
# these should have a preluding - in front of them
func _read_attr(body_line:String):
	# cut off the dash	
	var line_cont = body_line.substr(body_line.find("-") + 1)

	var substrs = line_cont.split(":")
	
	# the leftmost one is the identifier
	var ident = substrs[0].strip_edges().to_lower()

	var vals = ""
	var x_fils = false
	for val_ind in range(1, len(substrs)):
		vals += substrs[val_ind]
		if x_fils:
			vals += ":"
		x_fils = true
	
	vals = vals.strip_edges()
	
	match ident:
		"user" : 
			_read_user(vals)
		"pfp" : 
			_read_pfp(vals)
		"cmt" : 
			responses.append(Response.new(vals))
		_ : 
			assert(false, "Illegal comment attribute specified: %s" % ident)

func _read_user(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	user = content.substr(start + 1, end - start - 1)

func _read_pfp(content:String):
	var start = content.find("\"")
	var end = content.rfind("\"")
	pfp_str = content.substr(start + 1, end - start - 1)


func print_comment():
	print("(good_thresh, end_a_thresh, time_thresh) are (%d, %d, %d)" % [good_thresh, end_a_thresh, time_thresh])
	print("Comment: %s" % text)
	print("Username: %s" % user)
	print("Pfp file: %s" % pfp_str)
	for resp in responses:
		print("Response:")
		print("\t%s" % resp.text)
		print("\t(good_change, end_a_change): (%d, %d)" % [resp.good_change, resp.end_a_change])

func load_texture() -> ImageTexture:
	var retImg : ImageTexture = ImageTexture.new()
	var img : Image = Image.new()
	
	var err = img.load(PROFILE_PIC_PATH + pfp_str)
	if err != OK:
		assert(false, "Failed to load in a profile pic asset. Filename %s" % pfp_str)
		return retImg
	
	retImg.create_from_image(img)
	return retImg
	
	
class Response:
	var text = "EMPTY_RESPONSE"
	var good_change = 0
	var end_a_change = 0

	func _init(res_contents=null):
		assert(res_contents != null, "Need contents for a response, got null.")

		# first lets get the text set up
		var start = res_contents.find("\"")
		var end = res_contents.rfind("\"")
		text = res_contents.substr(start + 1, end - start - 1)

		# now we want to get the good and bad changes
		var c_params = res_contents.substr(end + 1).strip_edges().right(1)
		var val_strs = c_params.left(len(c_params) - 1).split(",")

		good_change = int(val_strs[0])
		end_a_change = int(val_strs[1])
		
	func print_response():
		print("Text is %s" % text)
		print("Good change and end_a_change are (%d, %d)" % [good_change, end_a_change])
	
