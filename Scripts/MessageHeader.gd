extends Button

signal conv_select(dec_unr, name)

const read_col = 0xffffff

var unread : bool = true
var speaker : String = "NO_SPEAKER_YET"

func init(speaker_name, unr):
	speaker = speaker_name
	unread = unr
	
func _ready():
	text = speaker
	
	_update_color()

func _on_Button_pressed():
	emit_signal("conv_select", unread, speaker)
	unread = false
	_update_color()

func _update_color():
	if unread: # if this is unread, we want this button to have a brighter color
		_set_color(Color.white)
	else:
		_set_color(Color.darkgray)
	yield(get_tree(), "idle_frame")


func _set_color(new_col: Color):
	add_color_override("font_color", new_col)
	add_color_override("font_color_hover", new_col)
	add_color_override("font_color_focus", new_col)
	add_color_override("font_color_pressed", new_col)
