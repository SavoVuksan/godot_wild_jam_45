extends Control

onready var content = $Panel/PauseMenuContent

var options_menu = preload("res://Blueprints/OptionsMenu.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionsButton_pressed():
	var content_child = content.get_child(0)
	content.remove_child(content_child)
	content_child.call_deferred("free")
	content.add_child(options_menu)
	print(options_menu)
