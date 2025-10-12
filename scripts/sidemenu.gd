extends Control

func exit():
	get_node("/root/main").show()
	get_tree().root.remove_child(self)

func meta_click(meta):
	OS.shell_open(str(meta))

func host_game():
	var server = ENetMultiplayerPeer.new()
	server.create_server(8080)
	get_tree().get_multiplayer().multiplayer_peer = server
	Singleton.user_id = 0
	get_tree().root.add_child(preload("res://scenes/game.tscn").instantiate())
	queue_free()
	print("HOSTING")
	print("Your ip " + str(IP.get_local_addresses()))
	print("Your id "+str(Singleton.user_id))

func join_game():
	var client = ENetMultiplayerPeer.new()
	var error = client.create_client($ip.text,8080)
	if error != OK:
		print("ERROR ",error)
	else:
		get_tree().get_multiplayer().multiplayer_peer = client
		Singleton.user_id = get_tree().get_multiplayer().get_unique_id()
		
		
func _ready() -> void:
	get_tree().get_multiplayer().peer_connected.connect(func (id):
		get_tree().root.add_child(preload("res://scenes/game.tscn").instantiate())
		queue_free()
		print("JOINING A GAME")
		print("Your id "+str(Singleton.user_id))
	)
