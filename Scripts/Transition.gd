extends CanvasLayer
signal transition_finished

export(Color)var fade_color = Color.black
export(float)var fade_time = 1

onready var tween = $Tween
onready var panel = $TransitionPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in():
	var transparent = fade_color
	transparent.a = 0
	tween.interpolate_property(panel,"modulate", fade_color, transparent, fade_time, Tween.TRANS_LINEAR)
	tween.start()

func fade_out():
	var transparent = fade_color
	transparent.a = 0
	tween.interpolate_property(panel, "modulate", transparent, fade_color, fade_time, Tween.TRANS_LINEAR)
	tween.start()


func _on_Tween_tween_completed(object:Object, key:NodePath):
	emit_signal("transition_finished")
