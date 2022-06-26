extends Node

# This script is autoload, should set in Project -> Project settings

onready var control: Node = get_tree().get_root().get_node("Control")

enum EditorMenu {Preferences}

var can_draw := false

var config_cache := ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# dim when dialog open
func dialog_open(open: bool) -> void:
	var dim_color := Color.white
	if open:
		can_draw = false
		dim_color = Color(0.5, 0.5, 0.5)
	else:
		can_draw = true

	control.get_node("ModulateTween").interpolate_property(
		control, "modulate", control.modulate, dim_color, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)

	control.get_node("ModulateTween").start()

# iterate tree recursively based on DFS, call method on each TreeItem
func iterate_tree(tree_item: TreeItem, method: String, params: Array):
	var child = tree_item.get_children()
	while child != null:
		iterate_tree(child, method, params)
		# visit tree_item
		call(method, child, params)
		child = child.get_next()

# a iterate method
func match_text(tree_item: TreeItem, params: Array):
	var input = params[0]
	if !(input.to_lower() in tree_item.get_text(0).to_lower()):
		var parent = tree_item.get_parent()
		# remove item only when all its children removed
		if tree_item.get_children() == null:
			parent.remove_child(tree_item)
			#print("remove " + tree_item.get_text(0))
