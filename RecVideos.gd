extends Node

var video1 = TempVideo.new( "1", "user1", "video 1", "res://big-buck-bunny_trailer.webm", "dash.png")
var video2 = TempVideo.new( "2", "user2", "video 2", "res://big-buck-bunny_trailer.webm", "dash.png")
var video3 = TempVideo.new( "3", "user3", "video 3", "res://big-buck-bunny_trailer.webm", "dash.png")
var video4 = TempVideo.new( "4", "user4", "video 4", "res://big-buck-bunny_trailer.webm", "dash.png")
var video5 = TempVideo.new( "5", "user5", "video 5", "res://big-buck-bunny_trailer.webm", "dash.png")
var video6 = TempVideo.new( "6", "user6", "video 6", "res://big-buck-bunny_trailer.webm", "dash.png")
var videos = [video1, video2, video3, video4, video5, video6]
var cur_video = video1

# Called when the node enters the scene tree for the first time.
func _ready():
	print( "YOUTUBE: " + videos[0].title)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
