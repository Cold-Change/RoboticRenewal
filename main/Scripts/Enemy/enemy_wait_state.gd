class_name EnemyWaitState
extends State

@export var actor: Enemy
@export var animator: AnimationPlayer

signal not_in_range_of_player
signal in_range_of_player

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	actor.velocity = Vector2.ZERO
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	await get_tree().create_timer(1.0).timeout
	if actor.detection_area.has_overlapping_areas():
		in_range_of_player.emit()
	else:
		not_in_range_of_player.emit()

