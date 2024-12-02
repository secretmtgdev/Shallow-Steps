extends Node2D

@onready var player: CharacterBody2D = $Visible/PlayerContainer/Player
@onready var player_starting_point: Marker2D = $Visible/PlayerContainer/PlayerStartingPoint

func _ready() -> void:
	player.position = player_starting_point.position
