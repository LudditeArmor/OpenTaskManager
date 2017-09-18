extends Button

var buttonID = 0
#For Handling Basic buttons
func _ready():
	#Send "pressed" signal to GUI node
	var guiNode = get_node("/root/AppRootNode/GUI")
	self.buttonID = randi()%373+1
	self.connect("pressed", guiNode, "BTN_handler", [get_name(), self.get_instance_ID(), buttonID]) 
