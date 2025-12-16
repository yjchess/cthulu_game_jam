@tool class_name Custom_ToolTip extends PanelContainer
@export var title:String = ""
@export var title_icon:String = ""
@export var show_title_icon:bool = false
@export var img_path:String = ""
@export var show_img:bool = false
@export var main_content:String = ""
@export var extra_content:String = ""
@export var update_editor:bool = false:
	set(v):
		update_content()

func _ready():
	size_flags_vertical = SizeFlags.SIZE_SHRINK_BEGIN
	update_content()
	

func update_content():
	%Header.text = title
	if show_title_icon:
		%Header_Icon.show()
		%Header_Icon.texture = load(title_icon)
	else:
		%Header_Icon.hide()
	
	if show_img:
		%Main_Img.show()
		%Main_Img.texture = load(img_path)
	else:
		%Main_Img.hide()
	
	%Main_Content.text = main_content
	if extra_content != "":
		%Extra_Content.show()
		%Extra_Content.text = extra_content
	else:
		%Extra_Content.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_content_from_item(item_id:Items_DB.ITEM):
	if item_id == Items_DB.ITEM.NONE:
		%Header.text = "No Item"
		%Main_Content.text = "Buy Items from the shop"
		return
	var item = Items_DB.get_item(item_id)
	%Header.text = item.item_name
	%Main_Content.text = item.descriptions.main_description
