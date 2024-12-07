extends Node

const FOOTSTEP = preload("res://scenes/characters/footstep.tscn")
const QTE_BAR = preload("res://scenes/bars/qte_bar.tscn")
const DIE_ROLLER = preload("res://scenes/objects/die_roller.tscn")

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

func _ready() -> void:
	SignalManager.game_over.connect(func(): get_tree().paused = true)

func set_difficulty(newDifficulty: GameDifficulty) -> void:
	CUR_DIFFICULTY = newDifficulty

func get_drain_rate() -> float:
	return DRAIN_BY_DIFFICULTY[CUR_DIFFICULTY]
	
func get_energy_percentage() -> float:
	return ENERGY / 100.0
	
func get_energy() -> float:
	return ENERGY

func set_energy(energyLevel: float) -> void:
	ENERGY = energyLevel
	
func decrease_energy() -> void:
	ENERGY -= get_drain_rate()
