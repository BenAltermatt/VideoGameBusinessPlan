extends PopupDialog

onready var label = get_node("PopupLabel")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PowerButton_pressed():
	# If the user has not uploaded a video today
	if ( !GameManager.uploaded ):
		#label.set_text("I need to upload before I log off today")
		popup()
	else :
		GameManager.newDay()
