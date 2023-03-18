extends Node

# const vars
const MAX_DAYS = 7
const MAX_ACTIONS = 5

# variables that determine what category the next action is in
enum action {UPLOAD, WATCH, COMMENT}


# Threshold values
var x = 0				# value that affects player getting dark past or crazy fan ending
var y = 0				# value that affects player getting good or bad ending
var currDay = 0			# current day in the game, cannot go below 0 or exceeed MAX_DAYS
var dayEnded = false		# value that changes depending on if a day is completed (player has used all their actions)
var numActions = 0		# the amount of actions that the player has used
var uploadedVideo = false	# value that determines if the player has uploaded a video (so player can end their day)
var lockEnding = 0.25	# value that determines how far player must be in the story to lock them to a specific ending
var lockGoodBad = 0.75	# value that determines how far player must be in the story to lock them to good or bad ending
var pathLocked = false	# the players path after getting locked
var goodBadLocked = false	# the player's path after

# Update player variables that affect the story options they may receive
# and increase day counter by 1
func updateCoords(xcoord, ycoord):
	x += xcoord
	y += ycoord
	
# get the players current coordinates on the decision graph to determine what videos/uploads/comments they see 
func getCoords():
	return Vector2(x, y)
	
func incrementActions():
	numActions+=1

# if the player has used all their actions/uploaded a video and pressed the power button
func endDay():
	if uploadedVideo:
		# end the day
		uploadedVideo = false
		currDay+=1

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
	if ((currDay / MAX_DAYS) >= lockEnding) and (pathLocked == false):		
		if (x > 0):
			print("Player is locked in to crazy fan ending")
		else:
			print("Player is locked in to dark past ending")
		pathLocked = true

func lockPlayerGoodOrBad():
	# lock player into good or bad ending based on y coordinates
	if ((currDay / MAX_DAYS) >= lockGoodBad) and (goodBadLocked == false):
		if (y > 0):
			print("Player is locked in to good ending")
		else:
			print("Player is locked in to bad ending")
		goodBadLocked = true


# check variables at the start of a new day
func newDay():
	
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
	# pass # Replace with function body.
	newDay()
	endDay()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
