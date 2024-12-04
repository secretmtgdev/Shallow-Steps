extends Node2D

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var response_timer: Timer = $ResponseTimer

var is_increasing: bool = true
var is_busy: bool = false
var progress_rate: float = 3
var progress: float = 0.0
var chances: int = 3

func _ready() -> void:
	progress_bar.value = progress

func _process(delta: float) -> void:
	if is_busy:
		return
	if Input.is_action_pressed("qte_default_action"):
		handle_user_input()
	update_progress_bar()

func handle_user_input() -> void:
	response_timer.start()
	is_busy = true
	if progress_bar.value >= 75:
		SignalManager.pass_qte.emit()
		queue_free()
	else:
		chances -= 1
		if chances == 0:
			SignalManager.fail_qte.emit(50)
			queue_free()
		
func update_progress_bar() -> void:
	if is_increasing:
		progress += progress_rate
		progress_bar.value = progress
		if progress_bar.value >= 100.0:
			is_increasing = false
	else:
		# progress_bar.value -= rate doesn't work
		progress -= progress_rate
		progress_bar.value = progress
		if progress_bar.value <= 0.0:
			is_increasing = true

func _on_response_timer_timeout() -> void:
	is_busy = false
