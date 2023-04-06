class_name StoryEvent

var og_sl = "NO_OG_SL"
var time = -1
var new_sls = []

func _init(block=null):
	assert(block != null, "Block needs an initial value for story events.")
	
	# we just need to parse the block
	var params = block.split(":")
	
	# these determine when/where the event triggers
	time = int(params[0].split(",")[0].strip_edges())
	og_sl = params[0].split(",")[1].strip_edges()
	
	# these are the options for the storyline to change to 
	# depending on which is most heavily favored
	for opts in params[1].split(","):
		new_sls.append(opts.strip_edges())

func print_event():
	print("%d, %s :" % [time, og_sl])
	var options = "\t"
	for key in new_sls:
		options += "%s, " % key
	print(options.substr(0, len(options) - 2))
