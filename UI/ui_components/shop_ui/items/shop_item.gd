@tool
class_name Shop_Item extends HBoxContainer
signal buy_button_pressed(item_id:int)

var item_id:int = 0
func setup(item_id:int, item_name:String, item_price:float, tooltip:String = ""):
	self.item_id = item_id
	%Item.text = "[center]" + item_name + "[/center]"
	%Price.text = "£"+str(item_price)
	self.tooltip_text = tooltip
	

func _on_buy_button_pressed() -> void:
	buy_button_pressed.emit(item_id)
