
# This class represents a single comment that can be displayed
# within the game
tool 
extends EditorScript
# These are all the things we can get out of a single 
# comment in a game
class_name Comment

var user : String = "NO_NAME"
var pfp : String = "NO_FILE"
var text : String = "NO_TEXT"
var good_thresh : int = 0
var end_a_thresh : int = 0
var time_thresh : int = 0
var responses = []


# I want to be able to parse a comment out of a string from a file
func _init(block):
	# it might be easiest to split these into lines
	var lines = block.split('\n')
	
	lines[0]
	
	user = "NO_NAME"
	pfp = "NO_FILE"
	text = "NO_TEXT"
	good_thresh = 0
	end_a_thresh = 0
	responses = []

class Response:
	var text = "EMPTY_RESPONSE"
	var good_change = 0
	var end_a_change = 0

	func _init(options):
		text = "EMPTY_RESPONSE"
		good_change = 0
		end_a_change = 0


func _run():
	print("AHAHAHHAHA")
