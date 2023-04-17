extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var num_videos = 6
var video_path = "res://VideoFiles/"
var thumbnail_path = "res://VideoThumbnails/"


# Called when the node enters the scene tree for the first time.
func _ready():
	num_videos = min(6, len(GameManager.cur_watches))
	set_up()
	var videoplayer = get_node("VideoPlayer")
	videoplayer.stop()
	pass # Replace with function body.

func set_up():
	if len(GameManager.cur_watches) > 0:
		var cur_vid = GameManager.cur_watches[0]
		var videoplayer = get_node("VideoPlayer")

		videoplayer.stream = cur_vid.load_vidstream()
		videoplayer.paused = false
		videoplayer.play()
		var title = get_node("Title")
		title.set_text(cur_vid.title)
		var user = get_node("User")
		user.set_text(cur_vid.user)
		var desc = get_node("Description")
		desc.set_text(cur_vid.desc)
		
		for n in range(1,num_videos):
			var rec_vid_node = get_node("Video" + str(n))
			rec_vid_node.visible = true
			
			var rec_vid = GameManager.cur_watches[n]
			rec_vid_node.get_node("Title").set_text(rec_vid.title)
			rec_vid_node.get_node("User").set_text(rec_vid.user)
			var image = rec_vid_node.get_node("TextureRect")
			var texture = load( thumbnail_path + rec_vid.thumbnail_fname )
			if (texture != null ):
				image.texture = texture
		
		for n in range(num_videos, 6):
			var rec_vid_node = get_node("Video" + str(n))
			rec_vid_node.visible = false

func set_video_current(index):
	#print("setting to index: " + str(index))
	GameManager.cur_video = GameManager.cur_watches[index]
	
	# when this happens, the video changes should be submitted to the game manager
	# GameManager.updateCoords(GameManager.cur_watches[index].good_change, GameManager.cur_watches[index].end_a_change)
	GameManager.update_prog(GameManager.cur_watches[index].changes)
	
	var shuffledList = [] 
	var indexList = range(len(GameManager.cur_watches))
	for i in range(len(GameManager.cur_watches)):
		var x = randi()%indexList.size()
		shuffledList.append(GameManager.cur_watches[indexList[x]])
		indexList.remove(x)
	GameManager.cur_watches = shuffledList
	for i in range(len(GameManager.cur_watches)):
		if GameManager.cur_watches[i] == GameManager.cur_video:
			#print( "found old index!")
			var temp = GameManager.cur_watches[0]
			GameManager.cur_watches[0] = GameManager.cur_video
			GameManager.cur_watches[i] = temp
	
	#for i in range(videos.size()):
	#	print(videos[i].title)
	
	#print(RecVideos.cur_video)
	set_up()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Youtube_pressed():
	self.hide()
	GameManager.single_vid = false
	GameManager.multiple_vid = true
	pass 


func _on_Button1_pressed():
	#print("Video 1 pressed!")
	set_video_current(1)
	pass 


func _on_Button2_pressed():
	#print("Video 2 pressed!")
	set_video_current(2)
	pass # Replace with function body.


func _on_Button3_pressed():
	#print("Video 3 pressed!")
	set_video_current(3)
	pass # Replace with function body.


func _on_Button4_pressed():
	#print("Video 4 pressed!")
	set_video_current(4)
	pass # Replace with function body.
	
	
func _on_Button5_pressed():
	#print("Video 5 pressed!")
	set_video_current(5)
	pass # Replace with function body.


