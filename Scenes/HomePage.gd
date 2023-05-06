extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var videos = GameManager.cur_watches
var num_videos = 6
var video_path = "res://VideoFiles/"
var thumbnail_path = "res://VideoThumbnails/"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up()
	pass # Replace with function body.
	
func set_up():
	videos = GameManager.cur_watches
	num_videos = min(6, len(GameManager.cur_watches))
	
	for n in range(0, num_videos):
		var rec_vid_node = get_node("Video" + str(n + 1) )
		rec_vid_node.visible = true
		var rec_vid = GameManager.cur_watches[n]
		rec_vid_node.get_node("Title").set_text(rec_vid.title)
		rec_vid_node.get_node("User").set_text(rec_vid.user)
		var image = rec_vid_node.get_node("Thumbnail")
		var texture = load( thumbnail_path + rec_vid.thumbnail_fname )
		if (texture != null ):
			print(rec_vid.thumbnail_fname)
			image.texture = texture
	
	for n in range(num_videos, 6):
		var rec_vid_node = get_node("Video" + str(n + 1) )
		rec_vid_node.visible = false


# when button pressed 

func open_single_view(index):
	if GameManager.num_watched < GameManager.MAX_WATCH:
		GameManager.num_watched += 1
		GameManager.single_vid = true
		GameManager.cur_vid_index = index
	else:
		$PopupDialog.popup()
	

func _on_Button1_pressed():
	open_single_view(0)


func _on_Button2_pressed():
	open_single_view(1)


func _on_Button3_pressed():
	open_single_view(2)


func _on_Button4_pressed():
	open_single_view(3)


func _on_Button5_pressed():
	open_single_view(4)


func _on_Button6_pressed():
	open_single_view(5)

