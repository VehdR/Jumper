extends Control

var gems_collected = 0
signal all_gems_collected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "x" + str(gems_collected)

func _on_gem_gem_collected():
	gems_collected += 1
	$Label.text = "x" + str(gems_collected)
	
	if gems_collected == 10:
		emit_signal("all_gems_collected")

func _on_character_death():
	print("joe")
	gems_collected = 0
	$Label.text = "x" + str(gems_collected)
	
