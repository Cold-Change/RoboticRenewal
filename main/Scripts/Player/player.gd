#class_name Player
extends CharacterBody2D

@export var movement_data : PlayerMovementData
const DEFAULT_PLAYER_MOVEMENT_DATA = preload("res://Resources/DefaultPlayerMovementData.tres")
const FAST_PLAYER_MOVEMENT_DATA = preload("res://Resources/FastPlayerMovementData.tres")

@export var stats : PlayerStats
@onready var animation_player = $AnimationPlayer
@onready var animation_manager = $AnimationManager

@onready var state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var player_attack_state = $FiniteStateMachine/PlayerAttackState as PlayerAttackState
@onready var player_walk_state = $FiniteStateMachine/PlayerWalkState as PlayerWalkState
@onready var player_idle_state = $FiniteStateMachine/PlayerIdleState as PlayerIdleState

func _ready():
	animation_player.play("Idle")
	state_machine.change_state(player_idle_state)
	player_walk_state.player_attack.connect(state_machine.change_state.bind(player_attack_state))
	player_walk_state.player_idle.connect(state_machine.change_state.bind(player_idle_state))
	player_attack_state.player_walk.connect(state_machine.change_state.bind(player_walk_state))
	player_idle_state.player_attack.connect(state_machine.change_state.bind(player_attack_state))
	player_idle_state.player_walk.connect(state_machine.change_state.bind(player_walk_state))

func _physics_process(delta):
	if state_machine.state != player_attack_state:
		move_and_slide()

