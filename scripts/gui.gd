extends Control

var b2 
var b1

var close_call = func close():
	visible = false

func close():
	close_call.call()


func _on_button_2_pressed():
	b2.call()


func _on_button_1_pressed():
	b1.call()
