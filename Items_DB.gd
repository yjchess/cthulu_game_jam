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
	
	NONE                   = -1,
	
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
	DESKTOP_ITEMS,
	ROOM_DECORATIONS,
	DOORS
	
}


class Item:
	var item_id: ITEM
	var item_name: String
	var item_price: float
	var owned: bool
	var base_path: String = "res://assets/"
	#main description = short description w.out much info
	#extra description = slighly more info + hints towards effects or lore
	#programmed_description = stat info
	
	var descriptions: Dictionary = {
		"main_description": "",
		"extra_description": "",
		"programmed_description": "",
	}
	
	func _init(item_id:ITEM, item_name:String, item_price:float, main_description:String = "", owned:bool = false):
		self.item_id = item_id
		var category = Items_DB.get_category_from_item_id(item_id)
		base_path = Items_DB.get_base_path_from_category(category)
		print(base_path)
		
		self.item_name = item_name
		self.item_price = item_price
		descriptions.main_description = main_description
		self.owned = owned
		

static var items =[
	Item.new(ITEM.BEANIE                 , "Beanie"                , 6.00   , "A Beanie to keep your noggin warm!"                                              ,),
	Item.new(ITEM.SUIT                   , "Suit"                  , 0.00   , "A flashy business type suit. It doesn't quite 'suit' you."                       ,true),
	Item.new(ITEM.WHITE_SHIRT            , "White Shirt"           , 0.00   , "A very formal, posh, tight white shirt."                                         ,true),
	Item.new(ITEM.SUIT_PANTS             , "Suit Pants"            , 0.00   , "I didn't know that suit's could pant!"                                           ,true),
	Item.new(ITEM.FORMAL_SHOES           , "Formal Shoes"          , 0.00   , "Rich people shoes with Oxfords not Brogues."                                     ,true),
	Item.new(ITEM.DOUBLE_STACKED_TABLES  , "2x Stacked Table"      , 0.00   , "Two unrelated tables stacked on top of each other."                              ,true),
	Item.new(ITEM.UNNAMED_OFFICE_CHAIR   , "Office chair"          , 0.00   , "Run of the mill, cheap, mass produced office chair."                             ,true),
	Item.new(ITEM.UNNAMED_EXEC_CHAIR     , "Executive chair"       , 150.00 , "Run of the mill, mediocre, mass produced executive chair."                       ,),
	Item.new(ITEM.MEMBRANE_KEYBOARD      , "Membrane kb"           , 0.00   , "Squishy, cheap - advertised as 'gaming' keyboard."                               ,true),
	Item.new(ITEM.MECHANICAL_KEYBOARD    , "Mechanical kb"         , 150.00 , "Mediocre keyboard with a decent Thock."                                          ,),
	Item.new(ITEM.OFFICE_MOUSE           , "Office Mouse"          , 0.00   , "Random Office Mouse from the 1900s."                                             ,true),
	Item.new(ITEM.GAMING_MOUSE           , "Gaming Mouse"          , 150.00 , "Mouse by the brand name: Rezar."                                                 ,),
	Item.new(ITEM.STANDARD_DUAL_MONITORS , "Standard 2x screens"   , 0.00   , "Dual monitors with some wear and tear."                                          ,true),
	Item.new(ITEM.PREMIUM_DUAL_MONITORS  , "Premium 2x screens"    , 150.00 , "Wider, higher-resolution, more gamery screens."                                  ,),
	Item.new(ITEM.CHEAP_TRIPLE_MONITORS  , "Cheap 3x screens"      , 210.00 , "Triple the screens... but not triple the efficiency :("                          ,),
	Item.new(ITEM.STANDARD_BASES         , "Standard bases"        , 0.00   , "Crooked Bases from an accidental drop."                                          , true),
	Item.new(ITEM.CHEAP_DESK_MOUNT       , "Cheap Desk Mount"      , 40.00  , "Also known as a monitor arm - although I thought they were 'armless'."           , ),
	Item.new(ITEM.CHEAP_WALL_MOUNT       , "Cheap Wall Mount"      , 30.00  , "A way of attaching your monitor to the wall."                                    , ),
	Item.new(ITEM.CHEAP_GRAPHICS_TABLET  , "Cheap Graphics Tablet" , 120.00 , "A beginner's graphics tablet."                                                   , ),
	Item.new(ITEM.GAME_DEV_MAGAZINE      , "Game Dev Mag."         , 30.00  , "AE's guide to scamming consumers!"                                               , ),
	Item.new(ITEM.POTTED_PLANT           , "Plant"                 , 10.00  , "More specifically, an Aloe Vera Plant."                                          , ),
	Item.new(ITEM.BATTLEMON_PLUSH        , "Battlemon plush"       , 80.00  , "It looks like a Mimmikyu, but due to international copyright laws, it's not!"    , ),
	Item.new(ITEM.DUSTBIN                , "Dustbin"               , 5.00   , "Garbage goes in, garbage comes out."                                             , ),
	Item.new(ITEM.SCI_FI_POSTER          , "Sci Fi Poster"         , 5.00   , "Poster of the hit tabletop wargame: 401K"                                        , ),
	Item.new(ITEM.MOVE_OUT               , "Move Out"              , 1250.00, "Finally... freedom. Time to leave the old door behind and explore new ventures." , ),
	Item.new(ITEM.MOVE_UPSTAIRS          , "Move Upstairs"         , 0.00   , "", ),
	
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
		SHOP_CATEGORIES.DESKTOP_ITEMS:
			return get_relevant_items(90,94)
		SHOP_CATEGORIES.ROOM_DECORATIONS:
			return get_relevant_items(95,99)
		
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

static func get_item(item_id:ITEM) -> Item:
	for item:Item in items:
		if item.item_id == item_id:
			return item
	return null

static func get_category_from_item_id(item_id:ITEM):
	if item_id < 10:
		return SHOP_CATEGORIES.HEAD
	elif item_id < 20:
		return SHOP_CATEGORIES.INNER_WEAR
	elif item_id < 30:
		return SHOP_CATEGORIES.OUTER_WEAR
	elif item_id < 40:
		return SHOP_CATEGORIES.LEG_WEAR
	elif item_id < 50:
		return SHOP_CATEGORIES.FOOT_WEAR
		
	elif item_id < 60:
		return SHOP_CATEGORIES.DESK_MODEL
	elif item_id < 70:
		return SHOP_CATEGORIES.CHAIR_MODEL
	elif item_id < 80:
		return SHOP_CATEGORIES.KEYBOARD_AND_MOUSE
	elif item_id < 90:
		return SHOP_CATEGORIES.MONITORS_AND_MOUNTS
	elif item_id < 95:
		return SHOP_CATEGORIES.DESKTOP_ITEMS
	elif item_id < 100:
		return SHOP_CATEGORIES.ROOM_DECORATIONS
	
	else:
		return SHOP_CATEGORIES.DOORS
	
static func get_base_path_from_category(category:SHOP_CATEGORIES):
	var base_path = "res://assets/"
	match category:
		SHOP_CATEGORIES.HEAD, SHOP_CATEGORIES.INNER_WEAR, SHOP_CATEGORIES.OUTER_WEAR, SHOP_CATEGORIES.LEG_WEAR, SHOP_CATEGORIES.FOOT_WEAR:
			base_path += "clothing_icons/"
		SHOP_CATEGORIES.DESK_MODEL, SHOP_CATEGORIES.CHAIR_MODEL, SHOP_CATEGORIES.KEYBOARD_AND_MOUSE, SHOP_CATEGORIES.MONITORS_AND_MOUNTS:
			base_path += "desk_icons/"
		SHOP_CATEGORIES.DESKTOP_ITEMS, SHOP_CATEGORIES.ROOM_DECORATIONS:
			base_path += "other_icons/"
	var final_directory:String = Utilities.convert_enum_to_string(SHOP_CATEGORIES, category)
	final_directory = final_directory.replace(" ", "_")
	final_directory = final_directory.to_lower()
	base_path += final_directory + "/"
	return base_path
