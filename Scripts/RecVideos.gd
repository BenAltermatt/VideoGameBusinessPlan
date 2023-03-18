extends Node

var READ_OBJECTS_PATH = "res://Scripts/ReadObjects.gd"
var readObjects = load(READ_OBJECTS_PATH).new()
var videos = readObjects.read_in_videos()
var cur_video = videos[0]
var single_vid = false
var multiple_vid = false
var cur_vid_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#print( "YOUTUBE: " + videos[0].title)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
