extends Node2D

@export var visible_layer: CanvasLayer

@onready var button_sprite: AnimatedSprite2D = $button_sprite
@onready var pulse_animation: AnimationPlayer = $AnimationPlayer
@onready var red_zone: Sprite2D = $RedZone

var damage = 0.1
var player_ref: Player = null
var interactable: bool = false
var buttonOff: bool = false

func _ready() -> void:
	button_sprite.play("Red") # use an sprite sheet
	pulse_animation.play("Pulse") # use on individual sprite

func _process(_delta: float) -> void:
	if player_ref and !buttonOff:
		player_ref.take_damage(damage)
		if interactable and Input.is_action_just_pressed("interact"):
			press_button()
			
func press_button() -> void:
	button_sprite.play("Green")
	pulse_animation.stop()
	red_zone.hide()
	buttonOff = true
	interactable = false
	#add_qte_bar()
	add_die_roller()
	
func add_die_roller() -> void:
	var die_roller = GameManager.DIE_ROLLER.instantiate()
	die_roller.global_position = position + Vector2(16, -64)
	visible_layer.add_child(die_roller)
	
func add_qte_bar() -> void:
	var qte_bar = GameManager.QTE_BAR.instantiate()
	qte_bar.scale = Vector2(0.7, 0.7)
	qte_bar.global_position = position + Vector2(16, -64)
	visible_layer.add_child(qte_bar)
	
func _on_drain_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_ref = body

func _on_drain_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_ref = null

func _on_button_area_body_entered(body: Node2D) -> void:
	if body is Player:
		interactable = true		

func _on_button_area_body_exited(body: Node2D) -> void:
	if body is Player:
		interactable = false
