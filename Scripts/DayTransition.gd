extends Node

var elapsed
var changed
var s_day

# Called when the node enters the scene tree for the first time.
func _ready():
	# this is  instantiated with the old day
	elapsed = 0
	changed = false
	s_day = GameManager.curDay
	
	get_node("ColorRect/RichTextLabel").text = ("Week %d" % (s_day - 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	
	if elapsed > 1 and not changed:
		get_node("ColorRect/RichTextLabel").text = ("Week %d" % s_day)
		changed = true
	
