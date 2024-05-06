class_name Player
extends CharacterBody2D

@export var movement_data: PlayerMovementData

@onready var arm = Globals.playerArm
@onready var legs = Globals.playerLegs
@onready var head = 0

@onready var attack_buffer_time = $AttackBufferTime
@onready var animation_player = $AnimationManager/AnimationPlayer
@onready var state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var player_attack_state = $FiniteStateMachine/PlayerAttackState as PlayerAttackState
@onready var player_walk_state = $FiniteStateMachine/PlayerWalkState as PlayerWalkState
@onready var player_idle_state = $FiniteStateMachine/PlayerIdleState as PlayerIdleState

func _ready():
	animation_player.play("idle")
	state_machine.change_state(player_idle_state)
	player_walk_state.player_attack.connect(state_machine.change_state.bind(player_attack_state))
	player_walk_state.player_idle.connect(state_machine.change_state.bind(player_idle_state))
	player_attack_state.player_walk.connect(state_machine.change_state.bind(player_walk_state))
	player_attack_state.player_idle.connect(state_machine.change_state.bind(player_idle_state))
	player_idle_state.player_attack.connect(state_machine.change_state.bind(player_attack_state))
	player_idle_state.player_walk.connect(state_machine.change_state.bind(player_walk_state))
	$AnimationManager/LeftArm.animation = "Idle"
	$AnimationManager/Body.animation = "Idle"
	$AnimationManager/Head.animation = "IdleRoomie"
	$AnimationManager/RightArm.visible = true
	if legs == "Basic":
		$AnimationManager/Legs.animation = "IdleBasic"
	else:
		$AnimationManager/Legs.animation = "IdleWheels"
	if arm == "Knife":
		$AnimationManager/RightArm.animation = "IdleKnife"
	elif arm == "Chainsaw":
		$AnimationManager/RightArm.animation = "IdleChainsaw"
	else:
		$AnimationManager/RightArm.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("attack1") or Input.is_action_just_pressed("attack2"):
		attack_buffer_time.start()
	if state_machine.state != player_attack_state:
		move_and_slide()

func take_damage(damage):
	Globals.playerHealth -= damage

func _on_hurt_box_area_entered(area):
	if area.collision_layer == 64:
		var damage = area.get_owner().attack
		take_damage(damage)
	elif area.collision_layer == 128:
		var damage = area.get_owner().attack * 1.5
		take_damage(damage)
