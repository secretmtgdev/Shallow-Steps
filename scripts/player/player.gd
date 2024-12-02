extends CharacterBody2D

class_name Player

@onready var previous_step: Marker2D = $PreviousStep
@onready var footstep: Node2D = $Footstep

const SPEED = 150.0
var direction = Utils.DirectionalFace.NORTH
var can_add_footprint = false
var is_light_on = false

func _ready() -> void:
	GameManager.ENERGY = 100.0

func _physics_process(_delta: float) -> void:
	handle_illuminate()
	handle_velocity()
	move_and_slide()
	if can_add_footprint and is_light_on:
		add_footprint()

func handle_illuminate() -> void:
	if Input.is_action_just_pressed("illuminate"):
		is_light_on = !is_light_on
		
	if is_light_on:
		footstep.show()
		SignalManager.light_on.emit()
		GameManager.ENERGY -= GameManager.ENERGY_DRAIN_RATE
		modulate.a = GameManager.get_energy()
	else:
		footstep.hide()
		SignalManager.light_off.emit()
		
func handle_velocity() -> void:
	var horizontal_direction := Input.get_axis("left", "right")
	var vertical_direction := Input.get_axis("up", "down")
	if !previous_step or global_position.distance_to(previous_step.position) >= 15:
		previous_step.position = global_position
		can_add_footprint = true
	else:
		can_add_footprint = false
	
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		velocity.y = 0
		direction = Utils.DirectionalFace.WEST if horizontal_direction < 0 else Utils.DirectionalFace.EAST
	elif vertical_direction:
		velocity.x = 0
		velocity.y = vertical_direction * SPEED
		direction = Utils.DirectionalFace.NORTH if vertical_direction < 0 else Utils.DirectionalFace.SOUTH
	else:
		velocity = Vector2.ZERO
			
	#print("Character is facing: %s" % Utils.get_direction_string(direction))

func add_footprint() -> void:
	var footprint = GameManager.FOOTSTEP.instantiate()
	footprint.position = previous_step.position
	footprint.modulate.a = GameManager.get_energy()
	get_parent().add_child(footprint)
	#print("Adding footprint at position: %v" % footprint.position)
