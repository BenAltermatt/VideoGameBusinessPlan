extends Node

const MAX_ACTIONS = 5
const USERNAME = "AubreyIRL"

# Threshold values
var curDay = 0				# current day in the game, cannot go below 0 or exceeed MAX_DAYS
var cur_sl = "main"			# this is the current branch in the game
var sl_vals = {} 			# this will track the progression of a value towards an ending 

var uploaded = false # this is the minimum requirement to end the day

# Serving values
var Comment = load("res://Scripts/Comment.gd")
var YTVideo = load("res://Scripts/Video.gd")
var Loader = load("res://Scripts/ReadObjects.gd")

# these are all of the values we can eventually serve.
# all are read in from files ahead of time and selected from when
# their criteria for display are met
var All_Comments = []
var All_Uploads = []
var All_Watches = []
var All_Convos = {}
var All_Events = {}

# these are the elements to be served on this given day
var cur_uploads = []
var cur_comments = [] 
var cur_watches = []

# convos are only added to over time, but they can be updated
# daily. We also keep track of whether they have been recently
# updated or not.
var cur_convos = {}
var update_convos = {} 

# This is all stuff ripped from Rio's singleton. We need to be able to reload videos depending
# on the day, so we can't use her singleton anymore.
var cur_video = null
var single_vid = false
var multiple_vid = false
var cur_vid_index = 0


# update the progression towards an ending or a branch value by 1
func update_prog(changes):
	for key in changes:
		if sl_vals.has(key):
			sl_vals[key] += changes[key]
		else:
			sl_vals[key] = changes[key]


# this is a group of functions that will be run every day which 
# determines some form of what resources for the story are available
# to the player to interact with based on their current progression

# eventually, this will require updating with some kind of interesting logic
# about selecting relevant portions of the story

# show upload options from the current week on this current timeline
func _serve_uploads():
	cur_uploads = []
	
	for upload in All_Uploads:
		if upload.sl == cur_sl and upload.time_thresh == curDay:
			cur_uploads.append(upload)

# show watch options from the current weeek on this current timeline
func _serve_watches():
	cur_watches = []
	
	for watch in All_Watches:
		if watch.sl == cur_sl and watch.time_thresh == curDay:
			cur_watches.append(watch)

# show the comments from the current week on this current timeline
func _serve_comments():
	cur_comments = []
	
	for comment in All_Comments:
		if comment.sl_tag == cur_sl and comment.day_thresh == curDay:
			cur_comments.append(comment)

# add the appropriate messages from the current weeek on this current timeline
func _serve_convos():
	print("what is going on")
	
	if All_Convos.has(cur_sl):
		for convo in All_Convos[cur_sl]:
			if convo.day == curDay:
				update_convos[convo.username] = true
				if cur_convos.has(convo.username):
					cur_convos[convo.username].append(convo)
				else:
					cur_convos[convo.username] = [convo]

# scan events on thsi timeline. If there is an event today, update the timeline.
func _register_event():
	var new_sl = ""
	var max_points = -INF
	
	if All_Events.has(cur_sl):
		for event in All_Events[cur_sl]:
			if event.time == curDay:
				for new_sl_opt in event.new_sls:
					var cur_points = 0
					if sl_vals.has(new_sl_opt):
						cur_points = sl_vals[new_sl_opt]
						
					if cur_points > max_points:
						new_sl = new_sl_opt
						max_points = cur_points
						
				cur_sl = new_sl

# check variables at the start of a new day
func newDay():
	# change to transition scene
	get_tree().change_scene("res://Scenes/DayTransition.tscn")
	
	# increment the current time frame by one
	curDay += 1
	
	# we have to properly update the storyline
	_register_event()
	
	# update the servings for the day
	_serve_uploads()
	_serve_watches()
	_serve_comments()
	_serve_convos()
	
	# reset our tracker for a valid end of day segment
	uploaded = true
	yield(get_tree().create_timer(1.5), "timeout")

	# get back to the basic website scene
	get_tree().change_scene("res://Scenes/WebWindow.tscn")
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# we need to load in our total videos and comments
	var All_Vids = Loader.read_in_videos()
	All_Comments = Loader.read_in_comments()
	All_Convos = Loader.read_in_messages()
	All_Events = Loader.read_in_events()
	
	# now is a good time to separate our videos
	# into our videos and not our videos
	for video in All_Vids:
		if video.user != USERNAME: 
			All_Watches.append(video)
		else: 
			All_Uploads.append(video)
		
			
	newDay() # set up the first day
