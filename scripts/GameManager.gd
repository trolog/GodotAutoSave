extends Node

export(PackedScene) var autosave_scene : PackedScene

var game_data : Dictionary

var autosave_length : int = 5
var autosave_start_time = 0 # 60 = 1 min

var playing = false # if this is running then countdown autosave

var player_x = 480
var player_y = 240

#We change values we save, we must update data before actual save
func update_data():
	game_data = {"player_data" : 
		{
			"posx" : player_x,
			"posy" : player_y,
		},
		"options" : 
		{
			"autosave" : autosave_length,
		}
	}
	
func do_save():
	update_data()
	var file : File = File.new() # new file
	file.open("res://saved_game/game.dat",File.WRITE) #makes one if doesn't exist
	file.store_line(to_json(game_data)) # store dictionary as json
	file.close() #Finished so close file
	
func do_load() -> bool:
	var file : File = File.new() # new file
	if(file.file_exists("res://saved_game/game.dat")): # check file exists
		file.open("res://saved_game/game.dat",File.READ) #open file
		
		game_data = parse_json(file.get_as_text()) #parse json into a dictionary
		
		file.close() # close file
		
		#Load the areas
		var option_data = game_data["options"]
		var player_data = game_data["player_data"]
		#load options
		autosave_length  = option_data["autosave"] # return autosave from options
		#Load player data
		GameManager.player_x = player_data["posx"]
		GameManager.player_y = player_data["posy"]
		
		return true
	else:
		return false

func _physics_process(delta: float) -> void:
	if(playing):
		autosave_logic()
		
func autosave_logic():
	#Remove start time from the current time returns secs
	var time_passed = OS.get_unix_time() - autosave_start_time
	#If secs are greater than our auto length * 60 (aka mins)
	if(time_passed > (autosave_length * 60)): 
		#instance the autosave animation
		var autosaveobject : AnimatedSprite = autosave_scene.instance()
		autosaveobject.global_position = Vector2(940,550)
		add_child(autosaveobject)
		
		do_save() # save
		
		#Reset the start_time so it loops
		autosave_start_time = OS.get_unix_time()
