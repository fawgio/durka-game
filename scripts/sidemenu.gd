extends Control

func exit():
	get_node("/root/main").show()
	get_node("/root/main/cam").enabled = true
	get_tree().root.remove_child(self)

func meta_click(meta):
	OS.shell_open(str(meta))
	
func full(b):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if !b else DisplayServer.WINDOW_MODE_FULLSCREEN)
	
func vsync(b):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED if !b else DisplayServer.VSYNC_ENABLED)
	
func fps(b):
	Singleton.fpsVisible = b
	
func vol(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
func muz(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func sfx(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func mut(b):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), b)
	
func lok(index):
	TranslationServer.set_locale("ru" if index == 0 else "en")


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
		get_tree().root.add_child(preload("res://scenes/game.tscn").instantiate())
		queue_free()
		print("JOINING A GAME")
		print("Your id "+str(Singleton.user_id))
