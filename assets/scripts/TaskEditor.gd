extends MarginContainer

var tmpType = "Once"
onready var GUInode = get_node("/root/AppRootNode/GUI")
var tmpSubtaskList = []
var tmpCategoryList = [] 

func _ready():
	# Called every time the node is added to the scene.
	print("Task Editor Opened")	
	# Initialization here
	#Selector for type of task
	var TypePopUpBTN = get_node("VSplitContainer/BTN_Type").get_popup()
	TypePopUpBTN.add_item("Once")
	TypePopUpBTN.add_item("Cyclical")
	TypePopUpBTN.add_item("Constant")
	TypePopUpBTN.add_item("Quick")
	TypePopUpBTN.connect("item_pressed", self, "_on_Type_PopUp_item_pressed")
	
	#Showing checkboxes to assign categories to task
	tmpCategoryList.resize(GUInode.rootNode.categories.size())
	for i in range(0, GUInode.rootNode.categories.size()):
		tmpCategoryList[i] = CheckBox.new()
		tmpCategoryList[i].set_name("CHKBOX_" + GUInode.rootNode.categories[i])
		tmpCategoryList[i].set_text(GUInode.rootNode.categories[i])
		get_node("VSplitContainer").add_child(tmpCategoryList[i])

#Button for assinging task type
func _on_Type_PopUp_item_pressed(ID):
	if(ID == 0):
		tmpType = "Once"
		get_node("VSplitContainer/BTN_Type").set_text("Once")
	if(ID == 1):
		tmpType = "Cyclical"
		get_node("VSplitContainer/BTN_Type").set_text("Cyclical")
	if(ID == 2):
		tmpType = "Constant"
		get_node("VSplitContainer/BTN_Type").set_text("Constant")
	if(ID == 3):
		tmpType = "Quick"
		get_node("VSplitContainer/BTN_Type").set_text("Quick")

#Calculates the reward for the task
func get_calc_reward(difficulty):
	var reward = (difficulty * 1.25)
	
	return reward
