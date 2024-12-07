extends Panel

@onready var current_number_label: Label = $CurrentNumberLabel
@onready var selected_number_timer: Timer = $SelectedNumberTimer

var rng = RandomNumberGenerator.new()
var tic: int = 0
var cur_num: int = 0
var waiting: bool = false

var min: int
var max: int

func _ready() -> void:
	set_dice_range()
	SignalManager.qte_in_progress.emit()
	
func _process(delta: float) -> void:
	if waiting:
		return
		
	if Input.is_action_pressed("qte_default_action"):
		handle_number_selection()
	
	tic += 1
	if tic % 6 == 0:
		spin_dice()
		
func handle_number_selection() -> void:
	selected_number_timer.start()
	waiting = true
		
func set_dice_range(start: int = 1, end: int = 6) -> void:
	min = start
	max = end
	
func spin_dice() -> void:
	var num = rng.randi_range(min, max)
	if num == cur_num:
		if num == max:
			num -= 1
		else:
			num += 1
	current_number_label.text = str(num)
	cur_num = num

func _on_change_number_timer_timeout() -> void:
	spin_dice()

func _on_selected_number_timer_timeout() -> void:
	SignalManager.dice_rolled.emit(cur_num)
	SignalManager.qte_is_done.emit()
	queue_free()
