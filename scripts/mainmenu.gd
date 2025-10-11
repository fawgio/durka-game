extends Control

var level
var options
var credits

func _ready() -> void:
	level = preload("res://scenes/game.tscn").instantiate()
	options = preload("res://scenes/options.tscn").instantiate()
	credits = preload("res://scenes/credits.tscn").instantiate()
	
	get_tree().root.add_child(credits)

func start():
	get_tree().root.add_child(level)
	$cam.enabled = false
	self.hide()
	
func opt():
	get_tree().root.add_child(options)
	self.hide()
	
func cred():
	get_tree().root.add_child(credits)
	self.hide()
	
func exit():
	get_tree().quit()
	
	
