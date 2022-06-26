extends Control

# Editor
var editor_menu: PopupMenu
onready var editor_menu_button: MenuButton = $MenuButtonContainer/EditorMenu

onready var preferences_dialog: AcceptDialog = Global.control.find_node("PreferencesDialog")

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_editor_menu()

func _setup_editor_menu() -> void:
	var items := [
		"Preferences",
	]
	editor_menu = editor_menu_button.get_popup()
	
	# add items into menu
	var i := 0
	for item in items:
		if item == "SubMenu":
			pass
			#_setup_recent_projects_submenu(item)
		else:
			editor_menu.add_item(item, i)
		i += 1
		
	# set handler to item button
	editor_menu.connect("id_pressed", self, "on_editor_menu_id_pressed")

func on_editor_menu_id_pressed(id: int) -> void:
	match id:
		Global.EditorMenu.Preferences:
			on_preferences_item_pressed()
		_:
			pass

func on_preferences_item_pressed():
	preferences_dialog.popup_centered(Vector2(600, 400))
	Global.dialog_open(true)
