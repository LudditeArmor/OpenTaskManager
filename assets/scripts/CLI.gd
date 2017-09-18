extends Container

#######################################
# EXPERIMENTAL COMMAND LINE INTERFACE #
#######################################

# class member variables go here
var CLI_version = "0.0.1"
var Input_node 
var Output_node
#States:
	#ListOptions
	#Show Tasks
var CLI_state
var Lastinput
var CurrentInput = ""
var isInputUpdated = false
onready var rootNode = get_node("/root/AppRootNode")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("CLI activated")
	set_process(true)
	set_process_input(true)
	Input_node = get_node("LineEdit")
	Output_node = get_node("RichTextLabel")
	SendOutput("Welcome to:")
	SendOutput("Open Task Manager CLI")
	SendOutput("Version: " + CLI_version)
	SendOutput("Today's date is: " + str(rootNode.currentDate))
	ListOptions()
	
func ListOptions():
	CLI_state = "ListOptions"
	Output_node.clear()
	SendOutput()
	SendOutput("What would you like to do?")
	SendOutput("(1) View all tasks")
	SendOutput("(2) Add a task")
	SendOutput("(3) Add a category")
	SendOutput("(4) Remove a category")
	SendOutput("(5) View categories")
	
func _input(event):
	if (event.is_action_pressed("ui_accept")):
		Lastinput = CurrentInput
		if(Lastinput != Input_node.get_text() or CurrentInput != ""):
			CurrentInput = Input_node.get_text()
			isInputUpdated = true
			#CommandHandler()
			print("Last Input: " + Lastinput)
			print("Current Input: " + CurrentInput)
		else:
			CurrentInput = ""
			isInputUpdated = false

func _process(delta):
	CommandHandler()

func CommandHandler():
	if (CurrentInput == "" or isInputUpdated == false):
		pass
	else:
		if (CLI_state == "ListOptions"):
			if (CurrentInput == "1"):
				pass
			if (CurrentInput == "2"):
				pass
			if (CurrentInput == "3"):
				isInputUpdated = false
				CLI_state = "AddCategory"
			if (CurrentInput == "4"):
				pass
				
		if (CLI_state == "AddCategory"):
			Output_node.clear()
			ShowCategoryList()
			SendOutput("Type category to add and press enter")
			if(isInputUpdated):
				rootNode.categories.append(CurrentInput)
				isInputUpdated = false
				ShowCategoryList()
				SendOutput("Category added: Press 'A' to continue")
				if(isInputUpdated and CurrentInput == "a"):
					ListOptions()

func ShowCategoryList():
	SendOutput("Current list of categories:")
	for i in range(0, rootNode.categories.size()):
		SendOutput(rootNode.categories[i])

func SendOutput(output = " "):
	if(output == " "):
		Output_node.newline()
	else:
		Output_node.newline()
		Output_node.append_bbcode(str(output))
	
	
