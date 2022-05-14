extends CanvasLayer
signal transition_finished

export(Color)var fade_color = Color.black
export(float)var fade_time = 1
export(bool)var fade_audio = true

onready var tween = $Tween
onready var panel = $TransitionPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in():
	var transparent = fade_color
	transparent.a = 0
	tween.interpolate_property(panel,"modulate", fade_color, transparent, fade_time, Tween.TRANS_LINEAR)
	if fade_audio:
		tween.interpolate_method(self,"change_db_on_master",0, 1, fade_time, Tween.TRANS_LINEAR)
	tween.start()

func fade_out():
	var transparent = fade_color
	transparent.a = 0
	tween.interpolate_property(panel, "modulate", transparent, fade_color, fade_time, Tween.TRANS_LINEAR)
	if fade_audio:
		tween.interpolate_method(self,"change_db_on_master",1, 0, fade_time, Tween.TRANS_LINEAR)
	tween.start()


func _on_Tween_tween_completed(object:Object, key:NodePath):
	emit_signal("transition_finished")

func change_db_on_master(percent):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(percent))
