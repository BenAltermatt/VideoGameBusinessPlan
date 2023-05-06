extends Control
class_name UploadManager

var YTVideo = load("res://Scripts/Video.gd")

var _allVideos = []
var _uploadOptionTemplate = load("res://Scenes/UploadOptionTemplate.tscn")
var _selectedVideo: YTVideo

# Called when the node enters the scene tree for the first time.
func _ready():
	#_allVideos = loadVideosFromFolder("res://UploadableVideos/")
	_allVideos = GameManager.cur_uploads
	_openPage(0, 0, 0)
	# warning-ignore:return_value_discarded
	get_node("VBoxContainer/MarginContainer/UploadButton").connect("pressed", self, "_uploadClicked")
	# warning-ignore:return_value_discarded
	get_tree().get_root().connect("size_changed", self, "_handleResize")

func _openPage(x: float, y: float, day: int):
	_selectedVideo = null
	_delete_children(get_node("VBoxContainer/Panel/GridContainer"))
	#var todaysVideos = _filterVideos(x, y, day)
	for i in range(len(_allVideos)):
		var template = _uploadOptionTemplate.instance()
		get_node("VBoxContainer/Panel/GridContainer").add_child((template))
		template._setUp(_allVideos[i], self)

func _videoSelected(video):
	_selectedVideo = video

func _uploadClicked():
	if _selectedVideo == null:
		return

	if not GameManager.uploaded:
		GameManager.update_prog(_selectedVideo.changes)
		GameManager.uploaded = true
	elif GameManager.cur_sl != GameManager.END:
		$PopupDialog.popup()
		

func loadVideosFromFolder(path: String) -> Array:
	var dir = Directory.new()
	var result = []
	dir.open(path)
	dir.list_dir_begin()
	var fileName = dir.get_next()
	while fileName != "":
		if not fileName.begins_with("."):
			result.append(load(path + fileName))
		fileName = dir.get_next()
	return result

static func _delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _handleResize():
	get_node("VBoxContainer/Panel/GridContainer").columns = OS.get_window_size().x / 64
