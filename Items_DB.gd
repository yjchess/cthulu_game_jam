@tool
class_name Items_DB extends Node

enum ITEM{
	#Clothing Items   Tier 1     0-49
	
	#Head             T1         0-9
	BEANIE = 0,
	
	#Inner Wear       T1         10-19
	WHITE_SHIRT = 10,
	
	#Outer Wear       T1         20-29
	SUIT = 20,
	
	#Leg Wear         T1         30-39
	SUIT_PANTS = 30,
	
	#Foot Wear        T1         40-49
	FORMAL_SHOES = 40,
	
	#Desk             Tier 1     50-
	
	#Desk Model       T1         50-59
	DOUBLE_STACKED_TABLES = 50,
	
	#Chair Model      T1         60-69
	UNNAMED_OFFICE_CHAIR = 60,
	UNNAMED_EXEC_CHAIR = 61,
	
	#Keyboard And Mouse   T1         70-79
	MEMBRANE_KEYBOARD = 70,
	MECHANICAL_KEYBOARD = 71,
	OFFICE_MOUSE = 75,
	GAMING_MOUSE = 76,
	
	#Monitor + Mounts    T1         80-89
	STANDARD_DUAL_MONITORS = 80,
	PREMIUM_DUAL_MONITORS  = 81,
	CHEAP_TRIPLE_MONITORS  = 82,
	STANDARD_BASES         = 85,
	CHEAP_DESK_MOUNT       = 86,
	CHEAP_WALL_MOUNT       = 87,
	
	#Other                  T1         90 -99
	
	#Desk Slot Items        T1
	CHEAP_GRAPHICS_TABLET  = 90,
	GAME_DEV_MAGAZINE      = 91,
	POTTED_PLANT           = 92,
	BATTLEMON_PLUSH        = 93,
	
	#Room Decorations      T1
	DUSTBIN                = 95,
	SCI_FI_POSTER          = 96,
	
	#Door
	#Tier 2 Doors:
	MOVE_OUT               = 1001,
	MOVE_UPSTAIRS          = 1002,
	
	#Tier 3 Doors:
	PURCHASE_TINY_HOUSE    = 1003,
	PURCHASE_CARAVAN       = 1004,
	
	
}

enum SHOP_CATEGORIES{
	HEAD,
	INNER_WEAR,
	OUTER_WEAR,
	LEG_WEAR,
	FOOT_WEAR,
	DESK_MODEL,
	CHAIR_MODEL,
	KEYBOARD_AND_MOUSE,
	MONITORS_AND_MOUNTS,
	DESK_TOP_ITEMS,
	ROOM_DECORATIONS,
	DOORS
	
}


class Item:
	var item_id: ITEM
	var item_name: String
	var item_price: float
	var owned: bool
	var descriptions: Dictionary = {
		"short_description": "",
		"medium_description": "",
		"long_description": "",
	}
	
	func _init(item_id:ITEM, item_name:String, item_price:float, owned:bool = false):
		self.item_id = item_id
		self.item_name = item_name
		self.item_price = item_price
		self.owned = owned
		

static var items =[
	Item.new(ITEM.BEANIE, "Beanie", 6.00),
	Item.new(ITEM.SUIT, "Suit", 0.00, true),
	Item.new(ITEM.WHITE_SHIRT, "White Shirt", 0.00, true),
	Item.new(ITEM.SUIT_PANTS, "Suit Pants", 0.00, true),
	Item.new(ITEM.FORMAL_SHOES, "Formal", 0.00, true),
	Item.new(ITEM.DOUBLE_STACKED_TABLES, "2x Stacked Table", 0.00, true),
	Item.new(ITEM.UNNAMED_OFFICE_CHAIR, "Office chair", 0.00, true),
	Item.new(ITEM.UNNAMED_EXEC_CHAIR, "Executive chair", 150.00),
	Item.new(ITEM.MEMBRANE_KEYBOARD, "Membrane kb", 0.00, true),
	Item.new(ITEM.MECHANICAL_KEYBOARD, "Mechanical kb", 150.00),
	Item.new(ITEM.OFFICE_MOUSE, "Office Mouse", 0.00, true),
	Item.new(ITEM.GAMING_MOUSE, "Gaming Mouse", 150.00),
	Item.new(ITEM.STANDARD_DUAL_MONITORS, "Standard 2x screens", 0.00, true),
	Item.new(ITEM.PREMIUM_DUAL_MONITORS,  "Premium 2x screens", 150.00),
	Item.new(ITEM.CHEAP_TRIPLE_MONITORS,  "Cheap 3x screens", 210.00),
	Item.new(ITEM.STANDARD_BASES, "Standard bases", 0.00, true),
	Item.new(ITEM.CHEAP_DESK_MOUNT, "Cheap Desk Mount", 40.00),
	Item.new(ITEM.CHEAP_WALL_MOUNT, "Cheap Wall Mount", 30.00),
	Item.new(ITEM.CHEAP_GRAPHICS_TABLET, "Cheap Graphics Tablet", 120.00),
	Item.new(ITEM.GAME_DEV_MAGAZINE, "Game Dev Mag.", 30.00),
	Item.new(ITEM.POTTED_PLANT, "Plant", 10.00),
	Item.new(ITEM.BATTLEMON_PLUSH, "Battlemon plush", 80.00),
	Item.new(ITEM.DUSTBIN, "Dustbin", 5.00),
	Item.new(ITEM.SCI_FI_POSTER, "Sci Fi Poster", 5.00),
	Item.new(ITEM.MOVE_OUT, "Move Out", 1250.00),
	Item.new(ITEM.MOVE_UPSTAIRS, "Move Upstairs", 0.00),
	
]

static var shop_tier:int = 1
static func get_items_from_category(category: SHOP_CATEGORIES):
	var category_items = []
	match category:
		#clothing
		SHOP_CATEGORIES.HEAD:
			return get_relevant_items(0, 9)
		SHOP_CATEGORIES.INNER_WEAR:
			return get_relevant_items(10, 19)
		SHOP_CATEGORIES.OUTER_WEAR:
			return get_relevant_items(20, 29)
		SHOP_CATEGORIES.LEG_WEAR:
			return get_relevant_items(30, 39)
		SHOP_CATEGORIES.FOOT_WEAR:
			return get_relevant_items(40,49)
		
		#desk
		SHOP_CATEGORIES.DESK_MODEL:
			return get_relevant_items(50, 59)
		SHOP_CATEGORIES.CHAIR_MODEL:
			return get_relevant_items(60, 69)
		SHOP_CATEGORIES.KEYBOARD_AND_MOUSE:
			return get_relevant_items(70,79)
		SHOP_CATEGORIES.MONITORS_AND_MOUNTS:
			return get_relevant_items(80,89)
		
		#other
		SHOP_CATEGORIES.DESK_TOP_ITEMS:
			return get_relevant_items(90,94)
		SHOP_CATEGORIES.ROOM_DECORATIONS:
			return get_relevant_items(95,100)
		
		#doors
		SHOP_CATEGORIES.DOORS:
			return get_relevant_items(1000,1010)

static func get_items_between_inclusive(lowest_id:int, highest_id:int):
	var eligible_items = []
	for item in Items_DB.items:
		if item.item_id >= lowest_id and item.item_id <= highest_id:
			eligible_items.append(item)
		if item.item_id > highest_id:
			return eligible_items #This is possible as Items_DB.items is sorted in ascending order
	return eligible_items

static func get_relevant_items(lowest_tier_one_id:int, highest_tier_one_id:int):
	var items
	var tier_one = get_items_between_inclusive(lowest_tier_one_id, highest_tier_one_id)
	var tier_two = get_items_between_inclusive(lowest_tier_one_id+100, highest_tier_one_id+100)
	
	items = tier_one.duplicate()
	if shop_tier >= 2:
		items.append_array(tier_two)
	
	return items
