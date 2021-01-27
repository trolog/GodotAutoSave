extends Sprite

var spd = 3 # speed of movement

func _ready() -> void:
	#Set player position, depends if we have a save or not
	global_position.x = GameManager.player_x
	global_position.y = GameManager.player_y

#Move using Arrow keys
func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("ui_up")):
		global_position.y -= spd
	if(Input.is_action_pressed("ui_down")):
		global_position.y += spd
	if(Input.is_action_pressed("ui_right")):
		global_position.x += spd
	if(Input.is_action_pressed("ui_left")):
		global_position.x -= spd
		
	#Update these values so when we auto save they're accurate
	GameManager.player_x = global_position.x
	GameManager.player_y = global_position.y
