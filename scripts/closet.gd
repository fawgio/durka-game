extends InaObject

@onready var stored = plr.CLOTHING.halat

func _ready() -> void:
	title = "Closet"
	text = "You can get or put your clothing here \n Inventory: " + stored.name
	buttons = ["Get clothing","Put clothing"]
	funcs = [
		func b1():
			if plr.clothing == plr.CLOTHING.no && stored != plr.CLOTHING.no:
				plr.clothing = stored
				stored = plr.CLOTHING.no
			exit(),
		
		func b2():
			if plr.clothing != plr.CLOTHING.no && stored == plr.CLOTHING.no:
				stored = plr.clothing
				plr.clothing = plr.CLOTHING.no
			exit()
		
	]

func _process(delta: float) -> void:
	text = "You can get or put your clothing here \n Inventory: " + stored.name
	if (stored != plr.CLOTHING.no):
		$spr.play("full")
	else: 
		$spr.play("empty")
	
