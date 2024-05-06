extends Node2D

@onready var game_over = $GameOver
@onready var health_bar = $UI/HealthBar

@onready var chainsaw_label = $UI/ChainsawLabel
@onready var knife_label = $UI/KnifeLabel
@onready var wheels_label = $UI/WheelsLabel
@onready var change_arm_label = $UI/ChangeArmLabel

@onready var wave_timer = $WaveTimer
@onready var wave_label = $WaveTimer/WaveLabel
@onready var time_label = $WaveTimer/TimeLabel
@onready var wave_animation = $WaveAnimation

@onready var enemies_defeated = %EnemiesDefeated
@onready var waves_survived = %WavesSurvived

@onready var game_over_tune = $GameOver/GameOverTune

@onready var roomie = $Roomie

func _ready():
	get_tree().paused = false

func _process(delta):
	if Globals.playerHealth <= 0:
		gameOver()
	manageUI()
	manageParts()
	health_bar.value = Globals.playerHealth
	time_label.text= "%02d:%02d"%time_left_in_round()
	

func _on_menu_pressed():
	@warning_ignore("unsafe_method_access")
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Views/TitleView.tscn")
	@warning_ignore("unsafe_method_access")
	LevelTransition.fade_from_black()

func _on_quit_pressed():
	get_tree().quit()

func manageParts():
	if Input.is_action_just_pressed("changeArm") and Globals.difficultyLevel >= 4:
		if Globals.playerArm == "Knife":
			Globals.playerArm = "Chainsaw"
		elif Globals.playerArm == "Chainsaw":
			Globals.playerArm = "Knife"
		roomie.arm = Globals.playerArm
		roomie.state_machine.change_state(roomie.player_idle_state)
	
func manageUI():
	if Globals.playerArm == "Chainsaw":
		chainsaw_label.visible = true
		knife_label.visible = false
	elif Globals.playerArm == "Knife":
		knife_label.visible = true
		chainsaw_label.visible = false
	else:
		knife_label.visible = false
		chainsaw_label.visible = false
	if Globals.playerLegs == "Wheels":
		wheels_label.visible = true
	else:
		wheels_label.visible = false
	
func time_left_in_round():
	var time_left = wave_timer.time_left
	var minute = floor(time_left/60)
	var second = int(time_left)%60
	return[minute,second]

func _on_wave_timer_timeout():
	wave_animation.play("FadeInFadeOut")
	for i in range(max(50 - Globals.difficultyLevel*5, 20)):
		if Globals.playerHealth <= 99:
			Globals.playerHealth += 1
			await get_tree().create_timer(.05).timeout
		elif Globals.playerHealth > 99:
			Globals.playerHealth = 100
	for i in range(5 + Globals.difficultyLevel):
			add_sibling(preload("res://Scenes/Enemy.tscn").instantiate())
	Globals.difficultyLevel += 1
	wave_timer.wait_time = max(wave_timer.wait_time - 2, 10)
	if Globals.difficultyLevel == 2:
		Globals.playerArm = "Knife"	
		roomie.arm = Globals.playerArm
		roomie.state_machine.change_state(roomie.player_idle_state)
	elif Globals.difficultyLevel == 3:
		Globals.playerLegs = "Wheels"	
		roomie.legs = Globals.playerLegs
		roomie.state_machine.change_state(roomie.player_idle_state)
	elif Globals.difficultyLevel == 4:
		Globals.playerArm = "Chainsaw"	
		roomie.arm = Globals.playerArm
		roomie.state_machine.change_state(roomie.player_idle_state)
		change_arm_label.visible = true

func gameOver():
	get_tree().paused = true
	game_over.visible = true
	game_over_tune.play()
	enemies_defeated.text = "Enemies Defeated: " + str(Globals.enemiesDefeated)
	waves_survived.text = "Waves Survived: " + str(Globals.difficultyLevel - 1)
