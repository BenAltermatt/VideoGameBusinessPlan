extends MarginContainer
class_name SelectableVideo

var _myVideo: UploadableVideoResource
var _uploadManager: UploadManager

func _ready():
	# warning-ignore:return_value_discarded
	get_node("Button").connect("pressed", self, "_videoClicked")

func _setUp(video: UploadableVideoResource, uploadManager: UploadManager):
	_myVideo = video
	_uploadManager = uploadManager
	get_node("VBoxContainer/TextureRect").texture = video.thumbNail
	get_node("VBoxContainer/Label").text = video.videoName + ".mp4"

func _videoClicked():
	_uploadManager._videoSelected(_myVideo)
