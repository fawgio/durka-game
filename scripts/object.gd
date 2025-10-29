extends CharacterBody2D
class_name InaObject

@onready var plr = get_tree().root.get_node("/root/game/player")
@onready var GUI : Control = plr.get_node("inaGUI")

@export var title : String= "Object"
@export var buttons : Array[String] = ["kill yourself","this crashes the game"]
@export var text : String = "This is an object"
@export var funcs : Array[Callable] = [func b1(): #default button actions
		plr.lives -= 1
		GUI.visible = false,func b2():
		plr.free()]
@export var inaFunc : Callable = func inaFunc(): #called on interaction
	GUI.close_call = exit
	GUI.visible = true #show GUI
	GUI.get_node("title").text = title #set title
	GUI.get_node("button1").visible = true #show button 1
	GUI.get_node("button1").text = buttons[0] #set button 1 title
	GUI.b1 = funcs[0] #set button 1 action
	GUI.get_node("button2").visible = true
	GUI.get_node("button2").text = buttons[1]
	GUI.b2 = funcs[1]
	GUI.get_node("text").text = text #set GUI's text

var p = position

func _physics_process(delta):
	velocity = Vector2.ZERO
	move_and_slide()
	position = p
			
			
func interact():
	inaFunc.call()
	

func exit():
	GUI.visible = false
	
func delete():
	queue_free()
