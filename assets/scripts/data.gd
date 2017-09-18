extends Node

var accountName = "TestUser"
var defaultPATH = ("user://" + accountName + "_data.json")
var database = {}

func _ready():
	pass
	
func _enter_tree():
	load_data()

func _exit_tree():
	save_data()
	
func set_key(key, value):
	database[key] = value
	
func get_key(key, default=null):
	if database.has(key):
		return database[key]
	else:
		return default
		
func clear():
	database = {}

func load_data(PATH = defaultPATH):
	var save = File.new()
	if !save.file_exists(PATH):
		print("No saved data found at: " + PATH)
		return
	var error = save.open(PATH,File.READ)
	if (error):
		print("Error opening data save file: " + str(err))
	
	var text = save.get_as_text()
	if text:
		database.parse_json(text)

func save_data(PATH = defaultPATH):
	var save = File.new()
	save.open(PATH, File.WRITE)
	save.store_string(database.to_json())
	print("Data saved to " + PATH)
	
func remove_saved_data(PATH = defaultPATH):
	var save = File.new()
	save.open(PATH, File.WRITE)
	save.store_string("")
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_data()
		get_tree().quit() # default behavior