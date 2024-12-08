class_name DieRoller extends RigidBody2D

@onready var current_number_label: Label = $DieRollerPanel/CurrentNumberLabel
@onready var selected_number_timer: Timer = $SelectedNumberTimer

var rng = RandomNumberGenerator.new()
var tic: int = 0
var cur_num: int = 0
var waiting: bool = false
var default_position: Vector2

var min: int
var max: int

func _ready() -> void:
	default_position = position
	set_dice_range()
	SignalManager.qte_in_progress.emit()
	SignalManager.die_hit.connect(handle_number_selection)
	
func _process(delta: float) -> void:
	if waiting:
		if default_position.y < position.y:
			set_deferred("freeze", true)
		return
		
	tic += 1
	if tic % 6 == 0:
		spin_dice()
		
func handle_number_selection() -> void:
	waiting = true
	selected_number_timer.start()
	linear_velocity += Vector2(0, -150)
		
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
	SignalManager.die_rolled.emit(cur_num)
	SignalManager.die_hit_done.emit()

func _on_about_to_collide_body_entered(body: Node2D) -> void:
	if body is DiePlayer:
		set_deferred("freeze", false)
