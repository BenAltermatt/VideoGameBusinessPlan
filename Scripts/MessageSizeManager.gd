extends Control

signal fin_x_resize
signal fin_y_resize

export(int) var margins
export(String) var text
export(bool) var left
var size_anchor

func init(pas_text, pas_margins, pas_left):
	text = pas_text
	margins = pas_margins
	left = pas_left
	$Label.text = text.strip_edges()
	$Label.get_stylebox("normal").set_expand_margin_all(margins)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# I need the node used to reference the max size to be correct
	size_anchor = get_parent().get_parent().get_parent()
	$Label.text = text.strip_edges()
	yield(get_tree(), "idle_frame")
	
	_resize_x()
	yield(self, "fin_x_resize")
	
	_resize_y()
	yield(self, "fin_y_resize")
	
	get_tree().get_root().connect("size_changed", self, "_on_window_resize")

# Called every frame. 'delta' is the elapsed time since the previous frame
func _on_window_resize():
	_resize_x()
	yield(self, "fin_x_resize")
	_resize_y()
	yield(self, "fin_y_resize")

func _resize_x():
	var max_x = int(size_anchor.rect_size.x * 2.0 / 3.0)
	var min_x = $Label.get_font("font").get_string_size($Label.text).x
	$Label.rect_size.x = min(max_x, min_x)
	
	if not left:
		$Label.rect_position.x = size_anchor.rect_size.x - $Label.rect_size.x - margins * 2
	else:
		$Label.rect_position.x = margins * 2
	
	yield(get_tree(), "idle_frame")
	emit_signal("fin_x_resize")

func _resize_y():
	var y_size = ($Label.get_line_height() + $Label.get_constant("line_spacing")) * $Label.get_visible_line_count()
	yield(get_tree(), "idle_frame")
	$Label.rect_size.y = y_size
	set_custom_minimum_size(Vector2(rect_size.x, y_size + margins))
	yield(get_tree(), "idle_frame")
	emit_signal("fin_y_resize")
