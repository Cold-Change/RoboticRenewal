class_name EnemyAttackState
extends State

@export var actor: Enemy
@export var animator: AnimationPlayer

signal exited_range

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	actor.velocity = Vector2.ZERO
	if actor.arm == "None":
		animator.play("jab1")
		await animator.animation_finished
		while actor.detection_area.has_overlapping_areas():
			animator.play("jab1")
			await animator.animation_finished
	elif actor.arm == "Knife":
		animator.play("knife1")
		await animator.animation_finished
		while actor.detection_area.has_overlapping_areas():
			animator.play("knife1")
			await animator.animation_finished
	elif actor.arm == "Chainsaw":
		animator.play("chainsaw1")
		await animator.animation_finished
		while actor.detection_area.has_overlapping_areas():
			animator.play("chainsaw1")
			await animator.animation_finished
	exited_range.emit()

func _exit_state() -> void:
	set_physics_process(false)

