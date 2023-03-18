extends TabContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PowerButton_pressed():
	pass # Replace with function body.
