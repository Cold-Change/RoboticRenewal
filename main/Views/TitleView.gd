extends Control

@onready var audio_stream_player = $AudioStreamPlayer

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	
func _on_start_pressed() -> void:
	@warning_ignore("unsafe_method_access")
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	@warning_ignore("unsafe_method_access")
	LevelTransition.fade_from_black()
	reset_globals()

func _on_quit_pressed() -> void:
	get_tree().quit()

func reset_globals():
	Globals.playerX = 0
	Globals.playerY = 0
	Globals.playerArm = "None"
	Globals.playerLegs = "Basic"
	Globals.playerAttack = 20
	Globals.playerHealth = 100
	Globals.difficultyLevel = 1

func _on_audio_stream_player_finished():
	audio_stream_player.play()
