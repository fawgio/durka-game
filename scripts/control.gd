extends Button
class_name RemappingButton

func _ready() -> void:
	set_process_input(false)
	pressed.connect(clicked)

func clicked():
	set_process_input(true)
	
func _input(event: InputEvent) -> void:
	if !event is InputEventKey and !event is InputEventMouseButton and !event is InputEventJoypadButton:
		return
		
	InputMap.action_erase_events(name)
	InputMap.action_add_event(name,event)
	text = event.as_text()
	set_process_input(false)
