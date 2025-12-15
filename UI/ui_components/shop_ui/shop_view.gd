@tool
extends VBoxContainer

var sub_title = preload("res://UI/ui_components/labels/ui_sub_title.tscn")
var shop_item = preload("res://UI/ui_components/shop_ui/items/shop_item.tscn")

@export var shop_title:String = "Shop:":
	set(v):
		shop_title = v
		$Shop_Title.text = shop_title

@export var shop_categories:Array[Items_DB.SHOP_CATEGORIES]:
	set(v):
		shop_categories = v
		for category:Items_DB.SHOP_CATEGORIES in shop_categories:
			display_category_items(category)
			

func display_category_items(category:Items_DB.SHOP_CATEGORIES):
	var category_title:String = Utilities.convert_enum_to_string(Items_DB.SHOP_CATEGORIES, category)
	category_title = category_title.replace(" And ", " & ")
	var items = Items_DB.get_items_from_category(category)
	
	var sub_title_instance = sub_title.instantiate()
	sub_title_instance.text = category_title
	add_child(sub_title_instance)
	
	for item:Items_DB.Item in items:
		var shop_item_instance: Shop_Item = shop_item.instantiate()
		shop_item_instance.setup(item.item_id, item.item_name, item.item_price)
		self.add_child(shop_item_instance)
