@tool
class_name Shop_Item extends HBoxContainer
signal buy_button_pressed(item_id:int)

var item_id:int = 0
		
func setup(item_id:int, item_name:String, item_price:float, item_tooltips:Dictionary):
	self.item_id = item_id
	%Item.text = "[center]" + item_name + "[/center]"
	%Price.text = "£"+str(item_price)

func _ready():
	%Custom_Tooltip.get_content_from_item(item_id)


func update_tooltip_global_positions():
	var current_global_position = %Control.global_position - Vector2(%Custom_Tooltip.size.x+15, %Custom_Tooltip.size.y/2 + self.size.y/2)
	%Custom_Tooltip.top_level = true
	%Custom_Tooltip.global_position = current_global_position

func _on_buy_button_pressed() -> void:
	buy_button_pressed.emit(item_id)


func _on_item_mouse_entered() -> void:
	update_tooltip_global_positions()
	%Custom_Tooltip.visible = true


func _on_item_mouse_exited() -> void:
	%Custom_Tooltip.visible = false
