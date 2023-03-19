extends Tabs


# Declare member variables here. Examples:
var single_vid = GameManager.single_vid
var multiple_vid = GameManager.multiple_vid
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("SingleWatchPage").hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	single_vid = GameManager.single_vid
	multiple_vid = GameManager.multiple_vid
	if (single_vid):
		var singleVidNode = get_node("SingleWatchPage")
		singleVidNode.set_video_current(GameManager.cur_vid_index)
		singleVidNode.show()
		GameManager.single_vid = false
	if (multiple_vid):
		#print("CHANGED TO MULTIPLE")
		var singleVidNode = get_node("HomePage")
		singleVidNode.set_up()
		GameManager.multiple_vid = false
		
	pass
