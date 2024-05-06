class_name PlayerIdleState
extends State

@export var actor: Player
@export var animator: AnimationPlayer

@onready var animation_manager = $"../../AnimationManager"

signal player_attack
signal player_walk

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	actor.velocity = Vector2.ZERO
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	var horizontal_axis = Input.get_axis("left", "right")
	var vertical_axis = Input.get_axis("up", "down")
	handle_movement(horizontal_axis, vertical_axis, delta)
	if Input.is_action_just_pressed("attack1") or (Input.is_action_just_pressed("attack2") and Globals.playerArm != "None"):
		player_attack.emit()
		
func handle_movement(horizontal_axis, vertical_axis, delta):
	if horizontal_axis != 0:
		player_walk.emit()
	elif vertical_axis != 0:
		player_walk.emit()
	Globals.playerX = actor.position.x
	Globals.playerY = actor.position.y
