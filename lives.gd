extends Control

var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_character_death():
	lives = lives - 1
	if lives <= 0:
		get_tree().change_scene_to_file("res://menu.tscn")
	elif lives == 1:
		$Heart2.visible = false
		$Heart3.visible = false
	elif lives == 2:
		$Heart3.visible = false
