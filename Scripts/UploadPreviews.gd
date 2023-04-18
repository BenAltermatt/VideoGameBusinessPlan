extends Control

const MAX_VIDS = 5
const video_path = "res://VideoFiles/"
const thumbnail_path = "res://VideoThumbnails/"

var uploads
var num_videos = 0
var cur_vid

# Called when the node enters the scene tree for the first time.
func _ready():
	uploads = GameManager.cur_uploads
	num_videos = min(MAX_VIDS, len(uploads))
	set_up()
	$VideoPlayer.stop()


# this sets everything up here for us
func set_up():
	# we don't really have to set up anything if there are no uploads
	if len(uploads) > 0:
		$VideoPlayer.visible = true
		
		_play_vid(0)
		
		for n in range(0,num_videos):
			var rec_vid_node = get_node("Video" + str(n + 1))
			rec_vid_node.visible = true
			
			var rec_vid = uploads[n]
			rec_vid_node.get_node("Title").set_text(rec_vid.video_fname)
			rec_vid_node.get_node("User").set_text(rec_vid.user)
			var image = rec_vid_node.get_node("TextureRect")
			var texture = load( thumbnail_path + rec_vid.thumbnail_fname )
			if (texture != null ):
				image.texture = texture
				
		for n in range(num_videos, MAX_VIDS):
			var rec_vid_node = get_node("Video" + str(n + 1))
			rec_vid_node.visible = false
	else:
		$VideoPlayer.visible = false
		_update_metadata(null)
		
		for n in range(0, MAX_VIDS):
			_turn_off(n + 1)

func _play_vid(ind):
	cur_vid = uploads[ind]
	$VideoPlayer.stream = cur_vid.load_vidstream()
	$VideoPlayer.paused = false
	$VideoPlayer.play()
	_update_metadata(cur_vid)

func _update_metadata(video):
	if video == null:
		$Title.visible = false
		$User.visible = false
		$Description.visible = false
	else:
		$Title.visible = true
		$Title.set_text(video.title)
		$User.visible = true
		$User.set_text(video.user)
		$Description.visible = true
		$Description.set_text(video.desc)
		
	
func _turn_off(ind):
	var pick_vid_node = get_node("Video" + str(ind))
	pick_vid_node.visible = false

func _on_Button1_pressed():
	_play_vid(0)


func _on_Button2_pressed():
	_play_vid(1)


func _on_Button3_pressed():
	_play_vid(2)


func _on_Button4_pressed():
	_play_vid(3)
	
	
func _on_Button5_pressed():
	_play_vid(4)


