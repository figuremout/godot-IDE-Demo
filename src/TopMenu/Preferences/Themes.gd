extends HBoxContainer

var theme_button_group := ButtonGroup.new()
onready var themes := [
	preload("res://assets/themes/blue/theme.tres"),
	preload("res://assets/themes/caramel/theme.tres"),
	preload("res://assets/themes/dark/theme.tres"),
	preload("res://assets/themes/gray/theme.tres"),
	preload("res://assets/themes/light/theme.tres"),
	preload("res://assets/themes/purple/theme.tres"),
]

onready var buttons_container: BoxContainer = $ThemesButtonContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for theme in themes:
		add_theme(theme)
	
	# select the current theme
	var theme_id: int = Global.config_cache.get_value("preferences", "theme", 0)
	if theme_id >= themes.size():
		theme_id = 0
	change_theme(theme_id)
	buttons_container.get_child(theme_id).pressed = true

func add_theme(theme: Theme) -> void:
	var button := CheckBox.new()
	var theme_name: String = theme.resource_name
	button.name = theme_name
	button.text = theme_name
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.group = theme_button_group
	buttons_container.add_child(button)
	button.connect("pressed", self, "_on_Theme_pressed", [button.get_index()])

func _on_Theme_pressed(index: int) -> void:
	buttons_container.get_child(index).pressed = true
	change_theme(index)

func change_theme(id: int) -> void:
	var theme: Theme = themes[id]
	Global.control.theme = theme
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
