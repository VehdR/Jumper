extends Control

var timer_on = false
var all_gems = false
var timer:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_on:
		timer += (delta*1000)
		
	var miliseconds = timer % 1000
	var seconds  = (timer / 1000) % 60
	var mins = timer / 60000
	
	if miliseconds == 0 && seconds == 0 && mins == 0:
		$Label.text = "00:00.000"
	elif seconds < 10 && mins < 10:
		$Label.text = "0" + str(mins) + ":0" + str(seconds) + "." + str(miliseconds)
	elif seconds >= 10 && mins < 10:
		$Label.text = "0" + str(mins) + ":" + str(seconds) + "." + str(miliseconds)
	else:
		$Label.text = str(mins) + ":" + str(seconds) + "." + str(miliseconds)
		

func _on_timer_check_toggle_timer():
	if !timer_on && !all_gems:
		timer_on = true
	elif timer_on && all_gems:
		timer_on = false


func _on_ui_all_gems_collected():
	all_gems = true
