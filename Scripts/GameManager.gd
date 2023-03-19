extends Node

# const vars
const MAX_DAYS = 7
const MAX_ACTIONS = 5
const USERNAME = "player"

# variables that determine what category the next action is in
enum action {UPLOAD, WATCH, COMMENT}


# Threshold values
var x = 0					# value that affects player getting dark past or crazy fan ending
var y = 0					# value that affects player getting good or bad ending
var curDay = 0				# current day in the game, cannot go below 0 or exceeed MAX_DAYS
var dayEnded = false			# value that changes depending on if a day is completed (player has used all their actions)
var numActions = 0			# the amount of actions that the player has used
var uploadedVideo = false	# value that determines if the player has uploaded a video (so player can end their day)
var lockEnding = 0.25		# value that determines how far player must be in the story to lock them to a specific ending
var lockGoodBad = 0.75		# value that determines how far player must be in the story to lock them to good or bad ending
var pathLocked = false		# the players path after getting locked
var goodBadLocked = false	# the player's path after

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


# Update player variables that affect the story options they may receive
# and increase day counter by 1
func updateCoords(xcoord, ycoord):
	x += xcoord
	y += ycoord
	
	print("Current Ending progression: (%d, %d)" % [x, y])
	
# get the players current coordinates on the decision graph to determine what videos/uploads/comments they see 
func getCoords():
	return Vector2(x, y)
	
func incrementActions():
	numActions+=1

# if the player has used all their actions/uploaded a video and pressed the power button
#func endDay():
#	if uploadedVideo:
#		# end the day
#		uploadedVideo = false
#		currDay+=1

# get next action from somewhere
func getNextAction():
	pass
	# do something

# player must upload video as one of their actions
# this function checks that the player has uploaded a video as at least one of their actions
func checkUpload(nextAction):
	# player is using their last action
	if numActions == 5:
		push_warning("You have already completed all your actions for the day. Time to go to sleep.")
	if numActions == 4:
		if nextAction != action.UPLOAD:
			push_warning("You must upload at least one video for the day!")
		numActions+=1
	else:
		if nextAction == action.UPLOAD:
			Upload(nextAction)
		elif nextAction == action.WATCH:
			Watch(nextAction)
		else:
			Comment(nextAction)
		numActions+=1

# Lock the player into a specific path once they reach a specific point
# in the story
func lockPlayerToEnding():
	# lock player into a specific path based on the x coordinates
	if ((curDay / MAX_DAYS) >= lockEnding) and (pathLocked == false):		
		if (x > 0):
			print("Player is locked in to crazy fan ending")
		else:
			print("Player is locked in to dark past ending")
		pathLocked = true

func lockPlayerGoodOrBad():
	# lock player into good or bad ending based on y coordinates
	if ((curDay / MAX_DAYS) >= lockGoodBad) and (goodBadLocked == false):
		if (y > 0):
			print("Player is locked in to good ending")
		else:
			print("Player is locked in to bad ending")
		goodBadLocked = true

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
	
	
	# check if player's ending has been locked yet
	lockPlayerToEnding()
	lockPlayerGoodOrBad()	
	

func Upload(action):
	# change current scene to be the upload screen
	get_tree().change_scene("res://Scenes/Upload.tscn")
	# serve next action to be uploading a video
func Watch(action):
	# change current scene to be the upload screen
	get_tree().change_scene("res://Scenes/Watch.tscn")
	# serve next action to be watching a video
func Comment(action):
	# change current scene to be the upload screen
	get_tree().change_scene("res://Scenes/Comment.tscn")
	# serve next action to be responding to a comment
	


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
			
	newDay() # set up the first day
	
	# pass # Replace with function body.
	#newDay()
	#endDay()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
