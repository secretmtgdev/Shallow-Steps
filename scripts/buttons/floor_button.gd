extends Node2D

@onready var button_sprite: AnimatedSprite2D = $button_sprite
@onready var pulse_animation: AnimationPlayer = $AnimationPlayer
@onready var red_zone: Sprite2D = $RedZone

var damage = 0.1
var playerRef: Player = null
var interactable: bool = false
var buttonOff: bool = false

func _ready() -> void:
	button_sprite.play("Red") # use an sprite sheet
	pulse_animation.play("Pulse") # use on individual sprite

func _process(_delta: float) -> void:
	if playerRef and !buttonOff:
		playerRef.take_damage(damage)
		if interactable and Input.is_action_just_pressed("interact"):
			press_button()		
			
func press_button() -> void:
	button_sprite.play("Green")
	pulse_animation.stop()
	red_zone.hide()
	buttonOff = true

func _on_drain_area_body_entered(body: Node2D) -> void:
	if body is Player:
		playerRef = body

func _on_drain_area_body_exited(body: Node2D) -> void:
	if body is Player:
		playerRef = null

func _on_button_area_body_entered(body: Node2D) -> void:
	if body is Player:
		interactable = true		

func _on_button_area_body_exited(body: Node2D) -> void:
	if body is Player:
		interactable = false
