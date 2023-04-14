class_name Message

var sl : String = "NO_STORYLINE"
var day : int = -1
var username : String = "NO_USER"
var message : String = ""
var to_player : bool = false

func _init(block=null):
	assert(block != null)
	
	var arg_str : String = block.substr(0, block.find(":") - 1)
	var args = arg_str.split(",")
	
	day = int(args[0].strip_edges())
	sl = args[1].strip_edges()
	username = args[2].strip_edges()
	to_player = args[3].strip_edges() == "true"
	
	# now we just have to read in the other side as the message
	var start : int = block.find(":")
	message = block.substr(start + 1, len(block) - start)
	
func print_message():
	print("week : %d, sl_name : %s, username: %s, to_player: %s" % [day, sl, username, str(to_player)])
	print("message : %s" % message)
