extends TabContainer

var MessageAlert : ImageTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://icons/youtube-icon.png")
	texture.create_from_image(image)
	set_tab_icon(0, texture)
	
	texture = ImageTexture.new()
	image = Image.new()
	image.load("res://icons/youtube-creator-icon.png")
	texture.create_from_image(image)
	set_tab_icon(1, texture)

	MessageAlert = ImageTexture.new()
	image = Image.new()
	image.load("res://icons/unr_msg.png")
	MessageAlert.create_from_image(image)
	$Messages.connect("update_content", self, "content_updated")
	set_tab_icon(2, MessageAlert)


func content_updated(new):
	if new:
		set_tab_icon(2, MessageAlert)
	else:
		set_tab_icon(2, null)
