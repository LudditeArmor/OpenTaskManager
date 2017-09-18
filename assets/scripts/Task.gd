extends MarginContainer

# class member variables go here
var title = "Title here"
var summary = "Short notes here"
var comment = "Notes here"
var TaskID = 0
var category = ["All", "Uncategorized"]
var TaskType = ""
var difficulty = 0
var reward = 1
var subtaskList = []
var is_expanded = false
var date
#var GRP_visibleOnExpand = "visibleOnExpand"

func _ready():
	# Initialization here
	get_node("VBoxContainer/TaskDone").set_text(title)
	get_node("VBoxContainer/LBL_Summary").set_text(summary)
	get_node("VBoxContainer/Comment").set_bbcode(comment)
	
	if(subtaskList.size() > 0):
		for i in range(0, subtaskList.size()-1):
			var subTask = CheckBox.new()
			subTask.set_text(subtaskList[i])
			get_node("VBoxContainer").add_child(subTask)

	for i in range(0, subtaskList.size()-1):
		var subTask = CheckBox.new()
		subTask.set_text(subtaskList[i])
		subTask.set_name("CHKBOX_" + subtaskList[i])
		get_node("VBoxContainer").add_child(subTask)
	
	for i in range(0, category.size()-1):
		var categoryLabel = Label.new()
		categoryLabel.set_text(category[i])
		categoryLabel.set_name("LBL_" + category[i])
		#get_node("VBoxContainer/LBL_Categories").get_position_in_parent()
		get_node("VBoxContainer").add_child(categoryLabel)
	#get_node("VBoxContainer/LBL_Type").set_text("Type: " + type)
	get_node("VBoxContainer/BAR_Difficulty").set_value(difficulty)
	get_node("VBoxContainer/LBL_Reward").set_text("Reward: " + str(reward))
	
	print("********************")
	print("New Task:")
	print("Title: " + title)
	print("Summary: " + summary)
	print("Comment: " + comment)
	print("Sub tasks: " + str(subtaskList))
	print("Category: " + str(category))
	print("Type: " + TaskType)
	print("Difficulty: " + str(difficulty))
	print("Reward: " + str(reward))
	print("********************")
	
	Expand(false)
	# Add nodes to a group that are only visible when task is expanded
#	get_node("VBoxContainer/Comment").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Categories").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Date").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Type").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Cycles").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Difficulty").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/BAR_Difficulty").add_to_group(GRP_visibleOnExpand)
#	get_node("VBoxContainer/LBL_Reward").add_to_group(GRP_visibleOnExpand)
	
func _on_TaskDone_pressed():
	
	for i in range(0, category.size()):
		if get_node("/root/AppRootNode").ScorePerCategory.has(category[i]):
			get_node("/root/AppRootNode").ScorePerCategory[category[i]] += self.reward
	#get_node("/root/AppRootNode").totalScore = get_node("/root/AppRootNode").ScorePerCategory[category[0]]
	
	if(self.TaskType == "Once" or self.TaskType == "Quick"):
		get_node("/root/AppRootNode").completedTasks.append(self.title)
		self.queue_free()
	else:
		get_node("VBoxContainer/TaskDone").set_pressed(false)
		
	print("Task " + self.title + " completed")
	print("New scores: ")
	print(str(get_node("/root/AppRootNode").ScorePerCategory))
	print(str(get_node("/root/AppRootNode").totalScore))
	print("History of completed tasks: " + str(get_node("/root/AppRootNode").completedTasks))

#View entire task (expand)
func Expand(toggle = false):
	var originalSize = self.get_size()
	var defaultExpansionScale = Vector2(1.5, 2.25)
	#Enable expansion
	if(toggle):
		self.set_size(self.get_size() * defaultExpansionScale) 
		get_node("VBoxContainer/Comment").show()
		get_node("VBoxContainer/LBL_Categories").show()
		get_node("VBoxContainer/LBL_Date").show()
		#get_node("VBoxContainer/LBL_Type").show()
		get_node("VBoxContainer/LBL_Cycles").show()
		get_node("VBoxContainer/LBL_Difficulty").show()
		get_node("VBoxContainer/BAR_Difficulty").show()
		get_node("VBoxContainer/LBL_Reward").show()
		for i in range(0, subtaskList.size()-1):
			get_node("VBoxContainer/CHKBOX_" + subtaskList[i]).show()
		for i in range(0, category.size()-1):
			get_node("VBoxContainer/LBL_" + category[i]).show()
	#Disable expansion
	if(toggle == false):
		self.set_size(self.get_size() / defaultExpansionScale)
		get_node("VBoxContainer/Comment").hide()
		get_node("VBoxContainer/LBL_Categories").hide()
		get_node("VBoxContainer/LBL_Date").hide()
		get_node("VBoxContainer/LBL_Type").hide()
		get_node("VBoxContainer/LBL_Cycles").hide()
		get_node("VBoxContainer/LBL_Difficulty").hide()
		get_node("VBoxContainer/BAR_Difficulty").hide()
		get_node("VBoxContainer/LBL_Reward").hide()
		for i in range(0, subtaskList.size()-1):
			get_node("VBoxContainer/CHKBOX_" + subtaskList[i]).hide()
		for i in range(0, category.size()-1):
			get_node("VBoxContainer/LBL_" + category[i]).hide()