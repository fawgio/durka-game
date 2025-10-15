extends InaObject

func _ready() -> void:
	title = "Napoleon"
	if plr.clothing != plr.CLOTHING.halat:
		buttons = ["Close","Next"]
		text = "Hi! I am cake!"
		funcs = [func b1(): #default button actions
			exit(),func b2():
			exit()
			text = "I wish I enslaved everyone..."
			funcs[1] = func b22():
				exit()
				text = "... And make them think they're cakes"
				interact()
			interact()]
	else:
		text = "Hi, Doctor!"
		funcs = [func b1(): #default button actions
			exit(),func b2():
				exit()
				interact()]

func exit():
	_ready()
	super.exit()
