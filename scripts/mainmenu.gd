extends Control

var level
var options
var credits
var multi

func _ready() -> void:
	level = preload("res://scenes/game.tscn")
	options = preload("res://scenes/options.tscn").instantiate()
	credits = preload("res://scenes/credits.tscn").instantiate()
	multi = preload("res://scenes/multi.tscn").instantiate()
	
	get_tree().root.add_child(credits)

func start():
	Singleton.user_id = 0
	get_tree().root.add_child( level.instantiate())
	$cam.enabled = false
	self.hide()
	
func _input(e : InputEvent):
	if Input.is_key_pressed(KEY_SHIFT):
		$VBoxContainer/opt.disabled = false
		$VBoxContainer/multi.disabled = false
	else:
		$VBoxContainer/opt.disabled = true
		$VBoxContainer/multi.disabled = true
	
func opt():
	get_tree().root.add_child(options)
	self.hide()
	
func mult():
	get_tree().root.add_child(multi)
	$cam.enabled = false
	self.hide()
	
func cred():
	get_tree().root.add_child(credits)
	self.hide()
	
func exit():
	get_tree().quit()
	
	
