class_name Footstep
extends Node2D

@export var under_player: bool;

@onready var point_light_2d: PointLight2D = $Sprite2D/PointLight2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dim_timer: Timer = $DimTimer

func set_alpha(alpha):
	modulate.a = alpha

func _ready() -> void:
	point_light_2d.energy = GameManager.get_energy_percentage()
	if under_player:
		animation_player.play("Pulsate")
	else:
		animation_player.play("Fade")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Fade"):
		queue_free()

func _on_dim_timer_timeout() -> void:
	point_light_2d.energy -= 0.05
