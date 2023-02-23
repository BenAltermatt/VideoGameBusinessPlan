extends Node

# const vars
const MAX_DAYS = 7
const MAX_ACTIONS = 5

# Scenes for each action
var Comment
var Upload
var Watch

# Threshold values
var x = 0				# value that affects player getting dark past or crazy fan ending
var y = 0				# value that affects player getting good or bad ending
var currDay = 0			# current day in the game, cannot go below 0 or exceeed MAX_DAYS
var dayEnded = false		# value that changes depending on if a day is completed (player has used all their actions)
var numActions = 0		# the amount of actions that the player has used


# Update player variables that affect the story options they may receive
# and increase day counter by 1
func updateCoords(xcoord, ycoord):
	x += xcoord
	y += ycoord
	
func incrementActions():
	numActions++

# Lock the player into a specific path once they reach a specific point
# in the story
func lockPlayerToPath():
	if ((MAX_DAYS % 4) <= currDay):
		# lock player into a specific path based on the x & y coordinates
		
		if (x > 0):
			# do something
		else:
			# do something
		if (y > 0):
			# do something
		else:
			# do something
	

# 
func Upload():
func Watch():
func Comment():
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
