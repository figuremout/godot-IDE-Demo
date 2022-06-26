extends Control

onready var quit_dialog: ConfirmationDialog = find_node("QuitDialog")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _notification(what: int) -> void:
#	match what:
#		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
#			show_quit_dialog()
#	get_tree().quit()

func show_quit_dialog() -> void:
	if !quit_dialog.visible:
		quit_dialog.call_deferred("popup_centered")
