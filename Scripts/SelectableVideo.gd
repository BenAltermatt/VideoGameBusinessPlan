extends MarginContainer
class_name SelectableVideo

var YTVideo = load("res://Scripts/Video.gd")

var _myVideo: YTVideo
var _uploadManager: UploadManager

func _ready():
	# warning-ignore:return_value_discarded
	get_node("Button").connect("pressed", self, "_videoClicked")

func _setUp(video: YTVideo, uploadManager: UploadManager):
	_myVideo = video
	_uploadManager = uploadManager
	get_node("VBoxContainer/TextureRect").texture = video.load_texture()
	get_node("VBoxContainer/Label").text = video.video_fname + ".mp4"

func _videoClicked():
	_uploadManager._videoSelected(_myVideo)
