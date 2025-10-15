extends InaObject

func _ready() -> void:
	title = "Emo"
	if plr.clothing != plr.CLOTHING.halat:
		buttons = ["Yes","No"]
		text = "Hello, stranger! Do you want by bat?"
		funcs = [func b1(): #default button actions
			exit()
			text = "Here you are. Keep it carefully. The doctors could take it away from me."
			plr.addItem("Bat")
			interact()
			GUI.get_node("button1").visible = false
			GUI.get_node("button2").visible = false,func b2():
			exit()
			text = "Ok..."
			interact()
			GUI.get_node("button1").visible = false
			GUI.get_node("button2").visible = false]
	else:
		text = "Hi, Doctor!"
		funcs = [func b1(): #default button actions
			exit(),func b2():
				exit()
				interact()]

func exit():
	_ready()
	super.exit()
