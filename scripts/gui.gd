extends Control

var b2 
var b1

func close():
	visible = false


func _on_button_2_pressed():
	b2.call()


func _on_button_1_pressed():
	b1.call()
