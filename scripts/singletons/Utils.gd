extends Node

enum DirectionalFace {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

var directionKeys = DirectionalFace.keys()

func get_direction_string(direction: DirectionalFace) -> String:
	return str(directionKeys[direction])
