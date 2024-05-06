class_name PlayerWalkState
extends State

@export var actor: Player
@export var animator: AnimationPlayer

@onready var animation_manager = $"../../AnimationManager"
@onready var player_collision_shape = %PlayerCollisionShape
const DEFAULT_PLAYER_MOVEMENT_DATA = preload("res://Resources/DefaultPlayerMovementData.tres")
const FAST_PLAYER_MOVEMENT_DATA = preload("res://Resources/FastPlayerMovementData.tres")

signal player_attack
signal player_idle

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("walk")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	var horizontal_axis = Input.get_axis("left", "right")
	var vertical_axis = Input.get_axis("up", "down")
	handle_movement(horizontal_axis, vertical_axis, delta)
	if Input.is_action_just_pressed("attack1") or (Input.is_action_just_pressed("attack2") and Globals.playerArm != "None"):
		player_attack.emit()
		
func handle_movement(horizontal_axis, vertical_axis, delta):
	if Input.is_action_pressed("run") and actor.legs == "Wheels":
		actor.movement_data = FAST_PLAYER_MOVEMENT_DATA
	if Input.is_action_just_released("run"):
		actor.movement_data = DEFAULT_PLAYER_MOVEMENT_DATA
	if horizontal_axis != 0:
		actor.velocity.x = move_toward(actor.velocity.x, actor.movement_data.horizontal_speed * horizontal_axis, actor.movement_data.horizontal_acceleration * delta)
		animation_manager.scale.x = horizontal_axis * abs(animation_manager.scale.x)
		if horizontal_axis > 0:
			player_collision_shape.position.x = -9
		else:
			player_collision_shape.position.x = 16
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, actor.movement_data.horizontal_friction * delta)
	if vertical_axis != 0:
		actor.velocity.y = move_toward(actor.velocity.y, actor.movement_data.vertical_speed * vertical_axis, actor.movement_data.vertical_acceleration * delta)
	else:
		actor.velocity.y = move_toward(actor.velocity.y, 0, actor.movement_data.vertical_friction * delta)
	if horizontal_axis == 0 and vertical_axis == 0:
		player_idle.emit()
	Globals.playerX = actor.position.x
	Globals.playerY = actor.position.y
