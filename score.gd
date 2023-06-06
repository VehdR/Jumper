extends Control

var score = Global.score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = Global.score
	$Label.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ui_gem_score():
	score = score + 42
	$Label.text = str(score)
	Global.score = score

func _on_skeleton_skeleton_score():
	score = score + 100
	$Label.text = str(score)
	Global.score = score
