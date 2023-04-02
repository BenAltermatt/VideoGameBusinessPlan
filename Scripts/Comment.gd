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
var day_thresh : int = 0
var sl_tag : String = "NO_SL"
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
	var start = top_line.find("(")
	var end = top_line.find(")", start)
	var args = top_line.substr(start + 1, end - start - 1).split(",")
	
	day_thresh = int(args[0].strip_edges())
	sl_tag = args[1].strip_edges().to_lower()

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
	print("(day_thresh, storyline_id) are (%d, %s)" % [day_thresh, sl_tag])
	print("Comment: %s" % text)
	print("Username: %s" % user)
	print("Pfp file: %s" % pfp_str)
	for resp in responses:
		resp.print_response()

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
	var changes = {}

	func _init(res_contents=null):
		assert(res_contents != null, "Need contents for a response, got null.")

		# first lets get the text set up
		var start = res_contents.find("\"")
		var end = res_contents.rfind("\"")
		text = res_contents.substr(start + 1, end - start - 1)

		# now we want to get the good and bad changes
		start = res_contents.rfind("(")
		end = res_contents.rfind(")")
		var sl_args = res_contents.substr(start + 1, end - start - 1).to_lower().split(",")
		
		# now, we have to add to the changes dictionary for each individual comment value
		for sl_change in sl_args:
			var sl = sl_change.split("=")[0].strip_edges()
			var change = int(sl_change.split("=")[1].strip_edges())
			
			if changes.has(sl):
				changes[sl] += change
			else:
				changes[sl] = change
		
	func print_response():
		print("Response Text: %s" % text)
		print("Response Changes:")
		for key in changes:
			print("\t%s : %d" % [key, changes[key]])
