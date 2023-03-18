extends PopupDialog

onready var label = get_node("PopupLabel")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_PowerButton_pressed():
	print("Popup!")
	#set_text("")
	var uploaded_today = false
	# If the user has not uploaded a video today
	if ( !uploaded_today ):
		#label.set_text("I need to upload before I log off today")
		popup()
	pass # Replace with function body.
