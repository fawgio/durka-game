extends CharacterBody2D
class_name InaObject

@onready var plr = get_tree().root.get_node("game/player")
@onready var GUI : Control = plr.get_node("inaGUI")

@export var title : String= "Object"
@export var buttons : Array[String] = ["kill yourself","this crashes the game"]
@export var text : String = "This is an object"
@export var funcs : Array[Callable] = [func b1():
		plr.lives -= 1
		GUI.visible = false,func b2():
		plr.free()]
@export var inaFunc : Callable = func inaFunc():
	GUI.visible = true
	GUI.get_node("title").text = title
	GUI.get_node("button1").visible = true
	GUI.get_node("button1").text = buttons[0]
	GUI.b1 = funcs[0]
	GUI.get_node("button2").visible = true
	GUI.get_node("button2").text = buttons[1]
	GUI.b2 = funcs[1]
	GUI.get_node("text").text = text

var p = position

func _physics_process(delta):
	velocity = Vector2.ZERO
	move_and_slide()
	position = p
			
			
func interact():
	inaFunc.call()
	

func exit():
	GUI.visible = false
