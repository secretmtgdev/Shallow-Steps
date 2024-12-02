extends Node

const FOOTSTEP = preload("res://scenes/characters/footstep.tscn")

enum GameDifficulty {
	EASY,
	MEDIUM,
	HARD
}

var ENERGY: float = 100.0
var CUR_DIFFICULTY = GameDifficulty.EASY

var DRAIN_BY_DIFFICULTY = {
	GameDifficulty.EASY: 0.01,
	GameDifficulty.MEDIUM: 0.05,
	GameDifficulty.HARD: 0.1
}

func get_drain_rate() -> float:
	return DRAIN_BY_DIFFICULTY[CUR_DIFFICULTY]
	
func get_energy() -> float:
	return ENERGY / 100.0
