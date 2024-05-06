class_name Enemy
extends CharacterBody2D

@export var movement_data : EnemyMovementData

@onready var arm = 1
@onready var legs = 1
@onready var head = 1
@onready var health = 100
@onready var speed = 70
@onready var attack = 3

@onready var animation_player = $AnimationManager/AnimationPlayer
@onready var animation_manager = $AnimationManager
@onready var detection_area = $AnimationManager/DetectionArea

@onready var state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var enemy_attack_state = $FiniteStateMachine/EnemyAttackState as EnemyAttackState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var enemy_wait_state = $FiniteStateMachine/EnemyWaitState as EnemyWaitState

func _ready():
	animation_player.play("idle")
	state_machine.change_state(enemy_wait_state)
	enemy_wait_state.not_in_range_of_player.connect(state_machine.change_state.bind(enemy_chase_state))
	enemy_wait_state.in_range_of_player.connect(state_machine.change_state.bind(enemy_attack_state))
	enemy_chase_state.entered_range.connect(state_machine.change_state.bind(enemy_wait_state))
	enemy_attack_state.exited_range.connect(state_machine.change_state.bind(enemy_wait_state))
	head = randi_range(1,3)
	legs = randi_range(1,2)
	arm = randi_range(1,3)
	$AnimationManager/LeftArm.animation = "Idle"
	$AnimationManager/Body.animation = "Idle"
	if head == 3:
		$AnimationManager/Head.animation = "IdleEnemy3"
		health -= randi_range(20,40)
		speed += randi_range(20,40)
		attack -= 1
	elif head == 2:
		$AnimationManager/Head.animation = "IdleEnemy2"
		health += randi_range(-10,10)
		speed += randi_range(-10,10)
	elif head == 1:
		$AnimationManager/Head.animation = "IdleEnemy1"
		health += randi_range(20,40)
		speed -= randi_range(20,40)
		attack += 1
	$AnimationManager/RightArm.visible = true
	if legs == 1:
		legs = "Basic"
		$AnimationManager/Legs.animation = "IdleBasic"
	else:
		legs = "Wheels"
		speed += 50
		$AnimationManager/Legs.animation = "IdleWheels"
	if arm == 1:
		arm = "Knife"
		$AnimationManager/RightArm.animation = "IdleKnife"
	elif arm == 2:
		arm = "Chainsaw"
		$AnimationManager/RightArm.animation = "IdleChainsaw"
	else:
		arm = "None"
		$AnimationManager/RightArm.visible = false
	randomPosition()

func _physics_process(delta):
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	queue_free()
	Globals.enemiesDefeated += 1

func _on_hurt_box_area_entered(area):
	if area.collision_layer == 8:
		var damage = Globals.playerAttack
		take_damage(damage)
	elif area.collision_layer == 16:
		var damage = Globals.playerAttack * 1.5
		take_damage(damage)
	elif area.collision_layer == 32:
		var damage = Globals.playerAttack * 2
		take_damage(damage)

func randomPosition():
	var yDisplacement = randi_range(-100, 100)
	var xDisplacement = randi_range(-100, 100)
	var rand = randi_range(0,1)
	if rand == 0:
		position = Vector2(200 + xDisplacement, 600 + yDisplacement)
	else:
		position = Vector2(1000 + xDisplacement, 600 + yDisplacement)
