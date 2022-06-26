extends VBoxContainer

onready var search_bar = $SearchBar
onready var tree: Tree = $Tree
onready var popup_menu : PopupMenu = $PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	tree.set_hide_root(true)
	tree.allow_reselect = true
	reset_whole_tree()

func reset_whole_tree():
	tree.clear()
	# root
	var root = tree.create_item()
	
	# root GUI
	var GUI = tree.create_item(root)
	GUI.set_text(0, "GUI")
	# root GUI Themes
	var themes = tree.create_item(GUI)
	themes.set_text(0, "Themes")
	# root GUI Language
	var language = tree.create_item(GUI)
	language.set_text(0, "Language")
	# test deeper
	var test = tree.create_item(language)
	test.set_text(0, "test")
	
	# root User
	var user = tree.create_item(root)
	user.set_text(0, "User")

##
# only show the matched tree items and their ancestors
##
func search_tree(input: String):
	var root = tree.get_root()
	# tree is cleared
	if root == null:
		return
	Global.iterate_tree(root, "match_text", [input])
	
func _on_SearchBar_text_changed(new_text):
	reset_whole_tree()
	if new_text == "":
		return
	search_tree(new_text)

##
# show menu when right-click on the tree item
##
var current_item : TreeItem
func _on_Tree_item_rmb_selected(position):
	current_item = tree.get_item_at_position(position)
	popup_menu.popup(Rect2(get_global_mouse_position(), popup_menu.get_minimum_size()))

func _on_Tree_item_rmb_edited():
	print("_on_Tree_item_rmb_edited")

func _on_PopupMenu_about_to_show():
	popup_menu.add_item("item")
	#var library_index : int = current_item.get_metadata(1)
	#var read_only : bool = library_manager.get_child(library_index).read_only
	#item_menu.set_item_disabled(0, read_only)
	#item_menu.set_item_disabled(1, read_only)
	#item_menu.set_item_disabled(2, read_only)

func _on_PopupMenu_index_pressed(index):
	pass # Replace with function body.
