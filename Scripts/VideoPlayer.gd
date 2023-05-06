extends VideoPlayer

var path_to_vid = "res://big-buck-bunny_trailer.webm"


func _on_Button_pressed():
	var currently_paused = is_paused()
	if (currently_paused):
		paused = false
	else:
		paused = true
	var currently_playing = is_playing()
	if (!currently_playing):
		play()


func _on_Youtube_pressed():
	stop()


func _on_Rewind_pressed():
	stream_position = 0
	set_stream_position(0)
