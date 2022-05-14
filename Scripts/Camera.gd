extends Camera2D


export(NodePath) var _target

onready var target = get_node(_target)

func _process(delta):
	position = target.position
