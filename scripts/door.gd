extends InaObject

var d : float = 1.0
var open

func _ready():
	for node in get_node("../../parts").get_children():
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	inaFunc = func inaFunc():
		get_node("col").disabled = !get_node("col").disabled # Disable CollisionBox allowing player to go through door
		open = true 
		for node in get_tree().root.get_node("game").get_children(): # Make enemies hear when a door is opening near them
			if node is Enemy && (abs(node.global_position - global_position).x < 200 && abs(node.global_position - global_position).y < 200):
				node.seenPlayer += 2
		
func _process(delta):
	if (rad_to_deg(get_node("spr").rotation)<=90.0)&&open: # Disable darkness in opened room
		get_node("../../parts").modulate = Color(0,0,0,d)
		get_node("spr").rotation = (1-d)*deg_to_rad(90)
		print(rad_to_deg(get_node("spr").rotation)," ",d)
		d-=delta*7.5
	if (rad_to_deg(get_node("spr").rotation)>=90.0):
		get_node("spr").rotation = deg_to_rad(90.0)
	if (rad_to_deg(get_node("spr").rotation)<=0.0):
		get_node("spr").rotation = deg_to_rad(0.0)
	get_node("spr").rotation = deg_to_rad(round(rad_to_deg(get_node("spr").rotation)))
	if !open:
		d = 1

	
	
