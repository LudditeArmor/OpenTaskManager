extends Node

		###################################################
		# 				Open Task Manager                 #
		###################################################
		# Open Source - Free to copy, edit and distribute #
		###################################################
		# 		TODO List created in Godot Engine 2       #
		###################################################
		
# class member variables go here,
var title = "Open Task Manager"
var version = "0.0.1"
var categories = ["All", 
				"Uncategorized", 
				"[A]_Important", 
				"[B]_Minor", 
				"[C]_Trivial"]
var currentDate = OS.get_date().values()
var isDebug = false
var completedTasks = {}
var ScorePerDay = {}
var ScorePerCategory = {categories[0]:0} 
var totalScore = ScorePerCategory[categories[0]]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("Starting...")
	print("App Name: " + title)
	print("Version: " + version)
	print("Screen size: " + str(get_node("GUI").screenSize))
	#set_process_input(true)
	#set_fixed_process(true)
	OS.set_window_title(title + " " + version)
	OS.set_window_resizable(true)
	randomize()
	
func ActivateCLI():
		var CLI_scene = load("res://assets/scenes/CLI.tscn")
		var CLI = CLI_scene.instance()
		add_child(CLI)
		
#Copyright Oliver Rühl ???
# returns timer you can wait for
# Usage: yield(AppRootNode.timer(0.5), "timeout") # wait for 0.5 seconds
func timer(time):
	var timer = Timer.new()
	timer.set_wait_time(time)
	add_child(timer)
	timer.start()
	timer.connect("timeout", timer, "queue_free")
	
	return timer

func CloseProgram():
	get_tree().quit()

#d_ = debug variable
func DebugMode():
	if(isDebug):
		var d_nodeList = []
		var d_rootNode = 0
	
	