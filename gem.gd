extends Area2D

signal gem_collected
var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	collected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if !collected:
		emit_signal("gem_collected")
		
	collected = true
	hide()

func _on_character_death():
	collected = false
	show()
