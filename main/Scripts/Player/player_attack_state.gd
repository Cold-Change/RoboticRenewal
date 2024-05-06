class_name PlayerAttackState
extends State

@export var actor: Player
@export var animator: AnimationPlayer

@onready var animation_manager = $"../../AnimationManager"

signal player_walk
signal player_idle

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	actor.velocity = Vector2.ZERO
	set_physics_process(true)
	if Input.is_action_just_pressed("attack1"):
		animator.play("jab1")
		await animator.animation_finished
		while actor.attack_buffer_time.time_left > 0:
			animator.play("jab2")
			await animator.animation_finished
	elif Input.is_action_just_pressed("attack2"):
		if actor.arm == "Chainsaw":
			animator.play("chainsaw1")
			await animator.animation_finished
			while actor.attack_buffer_time.time_left > 0:
				animator.play("chainsaw2")
				await animator.animation_finished
		if actor.arm == "Knife":
			animator.play("knife1")
			await animator.animation_finished
			while actor.attack_buffer_time.time_left > 0:
				animator.play("knife2")
				await animator.animation_finished
	player_walk.emit()

func _exit_state() -> void:
	set_physics_process(false)
