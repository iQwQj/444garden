extends Panel

@onready var item_visual: Sprite2D =$CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label


func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1: # only showing the number of items if > 1
							# if only 1 item just show the image
			amount_text.visible = true
		amount_text.text = str(slot.amount)
	
