extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
#var currently_playing = true
var path_to_vid = "res://big-buck-bunny_trailer.webm"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#stream = load(path_to_vid)
	#play()
	print("done loading")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#print( "video clicked")
	var currently_paused = is_paused()
	if (currently_paused):
		#stop()
		
		paused = false
	else:
		#play()
		paused = true
	var currently_playing = is_playing()
	if (!currently_playing):
		play()
	pass # Replace with function body.


func _on_Youtube_pressed():
	stop()
	pass # Replace with function body.
