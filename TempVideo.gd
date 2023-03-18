class_name TempVideo

var title : String
var user : String
var desc : String
var filename : String
var thumbnail_path: String

func _init( title: String, user : String, desc : String, filename : String, thumbnail_path: String ):
	self.title = title
	self.user = user
	self.desc = desc
	self.filename = filename
	self.thumbnail_path = thumbnail_path
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
