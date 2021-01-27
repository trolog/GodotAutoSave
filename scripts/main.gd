extends Node2D

func _ready() -> void:
	if(GameManager.do_load()): # Loaded saved game
		$lblautosave.text = "Auto Save in Mins : " + var2str(GameManager.autosave_length) # set label
		$hs_autosave.value = GameManager.autosave_length # set hslider value

func _on_hs_autosave_value_changed(value: int) -> void:
	$lblautosave.text = "Auto Save in Minutes : " + var2str(value)
	GameManager.autosave_length = value

func _on_btnPlay_pressed() -> void:
	GameManager.do_save()
	GameManager.playing = true
	GameManager.autosave_start_time = OS.get_unix_time()
	get_tree().change_scene("res://scenes/game.tscn")
