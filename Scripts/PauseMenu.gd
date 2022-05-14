extends Control

onready var pause_menu_content = $Panel/PauseMenuContent
onready var options_menu_content = $Panel/OptionsMenuContent
onready var exit_button : Button = $Panel/PauseMenuContent/VBoxContainer/ExitButton
onready var music_volume_slider: Slider = $Panel/OptionsMenuContent/VBoxContainer/VBoxContainer/MusicVolume/VolumeSlider
onready var sound_volume_slider: Slider = $Panel/OptionsMenuContent/VBoxContainer/VBoxContainer/SoundVolume/VolumeSlider
onready var mute_button: Button = $Panel/OptionsMenuContent/VBoxContainer/VBoxContainer/MuteButton
onready var audio = $Audio

var last_music_volume = 1
var last_sound_volume = 1

var music_audio_bus_index = AudioServer.get_bus_index("Music")
var sound_audio_bus_index = AudioServer.get_bus_index("Sounds")


func _ready():
	if OS.get_name() == 'HTML5':
		exit_button.visible = false
	
	music_volume_slider.value = db2linear(AudioServer.get_bus_volume_db(music_audio_bus_index))
	sound_volume_slider.value = db2linear(AudioServer.get_bus_volume_db(sound_audio_bus_index))


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func _on_OptionsButton_pressed():
	audio.play()
	pause_menu_content.visible = false
	options_menu_content.visible = true



func _on_OptionsMenuBackButton_pressed():
	audio.play()
	pause_menu_content.visible = true
	options_menu_content.visible = false


func _on_ExitButton_pressed():
	audio.play()
	get_tree().quit()

func toggle_pause():
	if self.visible:
		resume_game()
	else:
		pause_game()

func pause_game():
	self.visible = true
	get_tree().paused = true

func resume_game():
	self.visible = false
	get_tree().paused = false


func _on_ContinueButton_pressed():
	audio.play()
	resume_game()


func _on_MuteButton_toggled(button_pressed:bool):
	audio.play()
	if button_pressed:
		mute()
	else:
		unmute()

func mute():
	last_music_volume = music_volume_slider.value
	last_sound_volume = sound_volume_slider.value
	music_volume_slider.value = 0
	sound_volume_slider.value = 0
	set_audio_bus_volume()
	
func unmute():
	music_volume_slider.value = last_music_volume
	sound_volume_slider.value = last_sound_volume
	set_audio_bus_volume()

	
func set_audio_bus_volume():
	AudioServer.set_bus_volume_db(music_audio_bus_index,linear2db(music_volume_slider.value))
	AudioServer.set_bus_volume_db(sound_audio_bus_index,linear2db(sound_volume_slider.value))



func _on_MusicVolumeSlider_value_changed(value:float):
	set_audio_bus_volume()


func _on_SoundVolumeSlider_value_changed(value:float):
	set_audio_bus_volume()
