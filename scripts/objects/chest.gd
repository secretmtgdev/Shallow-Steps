extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var can_open = false
var opened = false

func _ready() -> void:
	animated_sprite_2d.play("closed")

func _process(_delta: float) -> void:
	if can_open and Input.is_action_just_pressed("interact"):
		opened = true
		animated_sprite_2d.play("opened")
	
func _on_interactable_body_entered(body: Node2D) -> void:
	if !opened and body is Player:
		can_open = true

func _on_interactable_body_exited(body: Node2D) -> void:
	if body is Player:
		can_open = false
