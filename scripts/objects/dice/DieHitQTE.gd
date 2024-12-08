extends Node2D

func _ready() -> void:
	SignalManager.die_hit_done.connect(func(): queue_free())
