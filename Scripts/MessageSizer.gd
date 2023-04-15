extends Control


var rtl : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	rtl = get_node("Panel/RichTextLabel")
	print(rtl.text)
	print(rtl.get_visible_line_count())
	rtl.fit_content = true
	#rect_size = rtl.get_font("normal_font").get_string_size(rtl.text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
