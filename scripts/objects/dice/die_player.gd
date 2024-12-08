class_name DiePlayer extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("qte_default_action") and is_on_floor():
		var intensity = Input.get_action_strength("qte_default_action")
		velocity.y = JUMP_VELOCITY * intensity

	if move_and_slide():
		detect_die_collision()
		
# Godot RigidBody2D can't detect collision with CharacterBody2D
# Here is my workaround
# https://github.com/godotengine/godot/issues/70671
func detect_die_collision() -> void:
	var last_collision = get_last_slide_collision()
	var collider = last_collision.get_collider()
	if collider is DieRoller:
		SignalManager.die_hit.emit()
