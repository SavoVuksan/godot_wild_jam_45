extends HBoxContainer


onready var viewport = $ViewportContainer/Viewport
onready var viewport2 = $ViewportContainer2/Viewport

func _ready():
	viewport2.world_2d = viewport.world_2d
