extends AcceptDialog

onready var search_bar = $VBoxContainer/SearchBar
onready var tree: Tree = $VBoxContainer/HSplitContainer/Tree
onready var right_side: VBoxContainer = $VBoxContainer/HSplitContainer/ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Replace OK since preference changes are being applied immediately, not after OK confirmation
	get_ok().text = tr("Close")
	
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



func _on_Tree_item_selected():
	var item = tree.get_selected()
	#print(item.get_text(0))
	
	# tree is set to allow reselect so that
	# the selected signal can be sent repeatedly if user click the item multi times,
	# but also remember to deselect it before change its collapsed status,
	# otherwise the item will keep selected, and selected signal will keep sent.
	# so that the program will crush
	if item.get_children() != null:
		item.deselect(0)
		item.collapsed = !item.collapsed
		return
		
	for child in right_side.get_children():
		child.visible = child.name == item.get_text(0)

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
	

