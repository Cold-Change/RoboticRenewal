extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("Intro")
	await animation_player.animation_finished
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Views/TitleView.tscn")
	LevelTransition.fade_from_black()
	
