extends Node

# const vars

const MAX_ACTIONS = 5
const USERNAME = "player"

# variables that determine what category the next action is in
enum action {UPLOAD, WATCH, COMMENT}


# Threshold values
var curDay = 0				# current day in the game, cannot go below 0 or exceeed MAX_DAYS
var cur_sl = "main"			# this is the current branch in the game
var sl_vals = {} 			# this will track the progression of a value towards an ending 

var uploaded = false # this is the minimum requirement to end the day

# Serving values
var Comment = load("res://Scripts/Comment.gd")
var YTVideo = load("res://Scripts/Video.gd")
var Loader = load("res://Scripts/ReadObjects.gd")

var All_Comments = []
var All_Uploads = []
var All_Watches = []

# these are the videos we decided to serve on this given day
var cur_uploads = []
var cur_comments = [] 
var cur_watches = []


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

func _serve_uploads():
	cur_uploads = All_Uploads
	
func _serve_watches():
	cur_watches = All_Watches
	
func _serve_comments():
	cur_comments = All_Comments

# check variables at the start of a new day
func newDay():
	# change to transition scene
	get_tree().change_scene("res://Scenes/DayTransition.tscn")
	
	# increment the current time frame by one
	curDay += 1
	
	# update the servings for the day
	_serve_uploads()
	_serve_watches()
	_serve_comments()
	
	# reset our tracker for a valid end of day segment
	uploaded = false
	yield(get_tree().create_timer(1.5), "timeout")

	# get back to the basic website scene
	get_tree().change_scene("res://Scenes/WebWindow.tscn")
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# we need to load in our total videos and comments
	var All_Vids = Loader.read_in_videos()
	All_Comments = Loader.read_in_comments()
	
	# now is a good time to separate our videos
	# into our videos and not our videos
	for video in All_Vids:
		if video.user != USERNAME: 
			All_Watches.append(video)
		#else: # we have this here for debugging rn
		All_Uploads.append(video)
			
	#newDay() # set up the first day
