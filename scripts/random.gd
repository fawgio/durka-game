extends Node2D

@export var floor: Vector2i = Vector2(0,0)
@export var wall: Vector2i = Vector2(1,4)

func _ready():
	var tm: TileMap = $"../tiles"
	tm.clear()
	#genRoom(tm, Vector2i(room_width, room_height), Vector2i(-20,0))

	for i in range(5,0,-1):
		genRoom(tm, Vector2i(40,40), Vector2i(-21,i*(39)-140))


func genRoom(tm: TileMap, size: Vector2i, origin: Vector2i):
	for y in range(size.y):
		for x in range(size.x):
			tm.set_cell(0,Vector2i(x + origin.x, y + origin.y), 1, floor)
	for x in range(size.x):
		tm.set_cell(0,Vector2i(x + origin.x, origin.y), 1, wall)
		tm.set_cell(0,Vector2i(x + origin.x, origin.y + size.y - 1), 1, wall)
	for y in range(size.y):
		tm.set_cell(0,Vector2i(origin.x, y + origin.y), 1, wall)                      
		tm.set_cell(0,Vector2i(origin.x + size.x - 1, y + origin.y), 1, wall)
	for x in range(4):
		tm.set_cell(0,Vector2i(x + origin.x + round(size.x/2) - 1,origin.y+size.y - 1), 1, floor)
	var room : Node2D = preload("res://scenes/room.tscn").instantiate()
	room.get_node("parts/roomPart1").size = size#*tm.tile_set.tile_size
	room.get_node("doors/door").global_position = Vector2(0,0)
	room.position = origin*tm.tile_set.tile_size
	room.name = "room"+str(origin.y)
	print(room)
	$"/root/game".add_child.call_deferred(room)
	
