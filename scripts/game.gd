extends Node2D

var players = 0

var peer_list = []

func _ready() -> void:
	get_tree().get_multiplayer().peer_connected.connect(func _connect(id):
		if Singleton.user_id == 0:
			$player.peer_list.append(id)
			print("Peer "+str(id)+ " joined!")
	)
	
func _process(delta: float) -> void:
	for peer in $player.peer_list:
		if !peer_list.has(peer):
			add_player(peer)
			peer_list.append(peer)
	
func _init() -> void:
	print("Add host")
	add_player(0)

func add_player(id,pname = "player"+str(players)):
	var player = preload("res://scenes/player.tscn").instantiate()
	player.name = pname if id != 0 else "player"
	player.user_id = id
	player.global_position = Vector2(-59,140)
	add_child(player)
	players+=1
	print("	Add player, id "+str(player.user_id) + ", count "+str(players))
