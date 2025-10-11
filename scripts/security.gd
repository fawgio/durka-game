extends NPC

@export var goto : Vector2 = Vector2(30,0)
var point = position + goto

func _ready() -> void:
	title = "Security"
	points = [position]
	inaFunc = func inaFunc():
		if plr.clothing == plr.CLOTHING.halat:
			points = [point]
		else:
			GUI.visible = true
			GUI.get_node("title").text = title
			GUI.get_node("button1").visible = false
			GUI.get_node("button2").visible = false
			GUI.get_node("text").text = "You are not a medic, so you're not allowed!"
