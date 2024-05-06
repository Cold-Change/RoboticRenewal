class_name EnemyChaseState
extends State

@export var actor: Enemy
@export var animator: AnimationPlayer

signal entered_range

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("walk")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	var horizontal_axis = 0
	var vertical_axis = 0
	if actor:
		if Globals.playerX < actor.position.x - 50:
			horizontal_axis = -1
		if Globals.playerX > actor.position.x + 50:
			horizontal_axis = 1
		if Globals.playerY < actor.position.y - 10:
			vertical_axis = -1
		if Globals.playerY > actor.position.y + 10:
			vertical_axis = 1
	handle_movement(horizontal_axis, vertical_axis, delta)
		
func handle_movement(horizontal_axis, vertical_axis, delta):
	if horizontal_axis != 0:
		actor.velocity.x = move_toward(actor.velocity.x, actor.movement_data.horizontal_speed * horizontal_axis * actor.speed/100, actor.movement_data.horizontal_acceleration * delta)
		actor.animation_manager.scale.x = horizontal_axis * abs(actor.animation_manager.scale.x)
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, actor.movement_data.horizontal_friction * delta)
	if vertical_axis != 0:
		actor.velocity.y = move_toward(actor.velocity.y, actor.movement_data.vertical_speed * vertical_axis * actor.speed/100, actor.movement_data.vertical_acceleration * delta)
	else:
		actor.velocity.y = move_toward(actor.velocity.y, 0, actor.movement_data.vertical_friction * delta)

func _on_detection_area_area_entered(area):
	if area.collision_layer == 2:
		await get_tree().create_timer(.2).timeout
		entered_range.emit()


