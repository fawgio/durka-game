extends Control

func exit():
	get_node("/root/main").show()
	get_tree().root.remove_child(self)

func meta_click(meta):
	OS.shell_open(str(meta))
